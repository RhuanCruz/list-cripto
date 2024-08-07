import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/configs/app_settings.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:flutter_estudo_1/pages/currency_details_page.dart';
import 'package:flutter_estudo_1/repository/currency_repository.dart';
import 'package:flutter_estudo_1/repository/favorite_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  late NumberFormat usd;
  late Map<String, String> loc;
  final table = CurrencyRepository.table;
  List<Currency> selecionadas = [];
  late FavoriteRepository favorites;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    usd = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'en_US' ? 'pt_BR' : 'en_US';
    final name = loc['locale'] == 'en_US' ? 'R\$' : '\$';

    return PopupMenuButton(
        icon: const Icon(Icons.language),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.swap_vert),
              title: Text('Use $locale'),
              onTap: () {
                context.read<AppSettings>().setLocale(locale, name);
                Navigator.pop(context);
              },
            ),
          )
        ]);
  }

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
        title: const Text(
          'Criptos',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [changeLanguageButton()],
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

  clearSelected() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // favorites = Provider.of<FavoriteRepository>(context);
    favorites = context.watch<FavoriteRepository>();
    readNumberFormat();
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
                title: Row(
                  children: [
                    Text(table[currency].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    if (favorites.lista.any((fav) => fav.sigle == table[currency].sigle))
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 255, 200, 0),
                        size: 22,
                      )
                  ],
                ),
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
                onPressed: () {
                  favorites.saveAll(selecionadas);
                  clearSelected();
                },
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
