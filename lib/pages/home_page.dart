import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:flutter_estudo_1/repository/currency_repository.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberFormat usd = NumberFormat.currency(locale: 'pt_BR', name: 'USD');
  final table = CurrencyRepository.table;
  List<Currency> selecionadas = [];


  currencyDetails(Currency currency){
    
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        backgroundColor: Colors.amber,
        title: Text('Criptos'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selected'),
        backgroundColor: Color.fromARGB(66, 192, 189, 189),
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black, size: 30),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int currency) {
            return ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              leading: (selecionadas.contains(table[currency]))
                  ? CircleAvatar(
                      child: Icon(Icons.check),
                    )
                  : SizedBox(
                      child: Image.asset(
                        table[currency].icon,
                      ),
                      width: 50,
                      height: 200,
                    ),
              title: Text(table[currency].name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              trailing: Text(
                usd.format(table[currency].price),
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              selected: selecionadas.contains(table[currency]),
              selectedTileColor: Color.fromARGB(238, 255, 193, 9),
              onLongPress: () {
                setState(() {
                  (selecionadas.contains(table[currency]))
                      ? selecionadas.remove(table[currency])
                      : selecionadas.add(table[currency]);
                });
              },
              onTap: () => currencyDetails(table[currency]),
            );
          },
          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
          itemCount: CurrencyRepository.table.length),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty ? FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 218, 171, 30),
        onPressed: () {},
        icon: Icon(
          Icons.star,
          color: Colors.white,
        ),
        label: Text(
          'FAVORITAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
            color: Colors.black87,
          ),
        ),
      ) : null
    );
  }
}
