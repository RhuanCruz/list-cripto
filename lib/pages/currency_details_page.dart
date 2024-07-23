import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:intl/intl.dart';

class CurrencyDetailsPage extends StatefulWidget {
  final Currency currency;

  CurrencyDetailsPage({super.key, required this.currency});

  @override
  State<CurrencyDetailsPage> createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage> {
  textDinamico() {
    if (widget.currency.dailyChange.toInt() > 0) {
      return (Text(
        "${widget.currency.dailyChange}%",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.w800, color: Colors.green),
      ));
    } else {
      return (Text(
        "${widget.currency.dailyChange}%",
        style: TextStyle(
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
                children: [Image.asset(widget.currency.icon)]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      "last price:",
                      style: TextStyle(fontSize: 21, color: Colors.black38),
                    ),
                  )
                ]),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "${usd.format(widget.currency.lastPrice)}",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    child: textDinamico(),
                  ),
                ]),
            Divider(),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      child: Text(
                        "ATH -  ${usd.format(widget.currency.highPrice)}",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            color: Colors.black54),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(Icons.notification_add_rounded),
                  ),
                ]),
          ],
        ));
  }
}
