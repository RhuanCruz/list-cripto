import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:flutter_estudo_1/pages/currency_details_page.dart';
import 'package:flutter_estudo_1/repository/currency_repository.dart';
import 'package:flutter_estudo_1/repository/favorite_repository.dart';
import 'package:flutter_estudo_1/widgets/currency_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  NumberFormat usd = NumberFormat.currency(locale: 'pt_BR', name: 'U\$');
  final table = CurrencyRepository.table;
  List<Currency> selecionadas = [];
  late FavoriteRepository favorites;

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
        title: const Center(
            child: Text(
          'Favorites',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
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
    favorites = context.watch<FavoriteRepository>();

    return Scaffold(
        appBar: appBarDinamica(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(15),
            child: Consumer<FavoriteRepository>(
                builder: (context, favorites, child) {
              return favorites.lista.isEmpty
                  ? ListTile(
                      leading: Icon(Icons.star),
                      title: Text("You haven't favorited any cryptos"),
                    )
                  : ListView.builder(
                      itemCount: favorites.lista.length,
                      itemBuilder: (_, index) {
                        return CurrencyCard(currency: favorites.lista[index]);
                      },
                    );
            })));
  }
}
