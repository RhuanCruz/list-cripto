import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:intl/intl.dart';

class CurrencyDetailsPage extends StatefulWidget {
  final Currency currency;

  const CurrencyDetailsPage({super.key, required this.currency});

  @override
  State<CurrencyDetailsPage> createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage> {
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quant = 0;

  purchase() {
    if (_form.currentState!.validate()) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Center(
          child: Text(
            "Purchase made", 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      )
      );
    }
  }

  textDinamico() {
    if (widget.currency.dailyChange.toInt() > 0) {
      return (Text(
        "${widget.currency.dailyChange}%",
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w800, color: Colors.green),
      ));
    } else {
      return (Text(
        "${widget.currency.dailyChange}%",
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w800, color: Colors.red),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat usd = NumberFormat.currency(locale: 'pt_BR', name: 'U\$');

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.currency.name),
        ),
        body: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 120,
                      width: 100,
                      child: Image.asset(widget.currency.icon))
                ]),
            const SizedBox(
              height: 15,
            ),
            const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text(
                      "Last price:",
                      style: TextStyle(fontSize: 21, color: Colors.black38),
                    ),
                  )
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    usd.format(widget.currency.lastPrice),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    child: textDinamico(),
                  ),
                ]),
            const Divider(),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "ATH -  ${usd.format(widget.currency.highPrice)}",
                      style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(123, 0, 0, 0)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Icon(Icons.notification_add_rounded),
                  ),
                ]),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: TextFormField(
                  controller: _valor,
                  style: const TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Valor',
                    prefixIcon: const Icon(Icons.monetization_on_outlined),
                    suffix: Text(
                      '$quant. ${widget.currency.sigle}',
                      style: const TextStyle(
                          fontSize: 16, color: Color.fromARGB(166, 0, 0, 0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o valor de aporte';
                    } else if (double.parse(value) < 50) {
                      return 'Compra minima é R\$ 50,00';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quant = (value.isEmpty)
                          ? 0
                          : double.parse(value) / widget.currency.price;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: 350,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 7),
              child: ElevatedButton(
                onPressed: () {
                  purchase();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Comprar",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
