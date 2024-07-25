import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:flutter_estudo_1/pages/currency_details_page.dart';
import 'package:flutter_estudo_1/repository/currency_repository.dart';
import 'package:flutter_estudo_1/repository/favorite_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrencyCard extends StatefulWidget {
  Currency currency;

  CurrencyCard({super.key, required this.currency});

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  NumberFormat usd = NumberFormat.currency(locale: 'pt_BR', name: 'U\$');
  final table = CurrencyRepository.table;
  late FavoriteRepository favorites;

  currencyDetails(Currency currency) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CurrencyDetailsPage(currency: currency),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => currencyDetails(widget.currency),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.currency.icon,
                height: 40,
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currency.name,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.currency.sigle,
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.amber, Colors.white],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                  border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  usd.format(widget.currency.price),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    letterSpacing: -1,
                  ),
                ),
              ),
              PopupMenuButton(
                  color: Colors.white,
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          
                          child: ListTile(
                          title: const Text("Unfavorite"),
                          onTap: () {
                            Navigator.pop(context);
                            Provider.of<FavoriteRepository>(context,
                                    listen: false)
                                .remove(widget.currency);
                          },
                        ))
                      ])
            ],
          ),
        ),
      ),
    );
  }
}
