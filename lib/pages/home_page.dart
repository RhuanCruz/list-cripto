import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:flutter_estudo_1/pages/currency_details_page.dart';
import 'package:flutter_estudo_1/repository/currency_repository.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumberFormat usd = NumberFormat.currency(locale: 'pt_BR', name: 'U\$');
  final table = CurrencyRepository.table;
  List<Currency> selecionadas = [];

  currencyDetails(Currency currency) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CurrencyDetailsPage(currency: currency),
        ));
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        backgroundColor: Colors.amber,
        title: const Center(child: Text('Criptos', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selected'),
        backgroundColor: const Color.fromARGB(66, 192, 189, 189),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
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
                    ? const CircleAvatar(
                        child: Icon(Icons.check),
                      )
                    : SizedBox(
                        width: 50,
                        height: 200,
                        child: Image.asset(
                          table[currency].icon,
                        ),
                      ),
                title: Text(table[currency].name,
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                trailing: Text(
                  usd.format(table[currency].price),
                  style: const TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                selected: selecionadas.contains(table[currency]),
                selectedTileColor: const Color.fromARGB(238, 255, 193, 9),
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
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: CurrencyRepository.table.length),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selecionadas.isNotEmpty
            ? FloatingActionButton.extended(
                backgroundColor: Colors.amber,
                onPressed: () {},
                icon: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                label: const Text(
                  'FAVORITAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                    color: Colors.black87,
                  ),
                ),
              )
            : null);
  }
}
