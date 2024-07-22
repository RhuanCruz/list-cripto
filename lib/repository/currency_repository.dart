import 'package:flutter_estudo_1/models/currency.dart';

class CurrencyRepository {
  bool isSorted = false;
  static List<Currency> table = [
    Currency(
        icon: 'assets/btc.png', name: 'Bitcoin', price: 70000, sigle: 'BTC'),
    Currency(
        icon: 'assets/eth.png', name: 'Etherium', price: 3000, sigle: 'ETH'),
    Currency(
        icon: 'assets/cardano.png', name: 'Cardano', price: 2000, sigle: 'ADA'),
    Currency(
        icon: 'assets/tether.png', name: 'Tether', price: 1500, sigle: 'THT'),
    Currency(
        icon: 'assets/doge.png', name: 'Doge', price: 500, sigle: 'DOG'),
    Currency(
        icon: 'assets/plkadot.png', name: 'Polkadot', price: 550, sigle: 'POL'),
  ];

  // sort() {
  //   if (!isSorted) {
  //     table.sort((Currency a, Currency b) => a.price.compareTo(b.price));
  //     isSorted = true;
  //   } else {
  //     table = table.reversed.toList();
  //   }
  // }
}

