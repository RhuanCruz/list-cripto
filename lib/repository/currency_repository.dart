import 'package:flutter_estudo_1/models/currency.dart';

class CurrencyRepository {
  static List<Currency> table = [
    Currency(
      icon: 'assets/btc.png',
      hero: '',
      name: 'Bitcoin',
      price: 70000,
      sigle: 'BTC',
      lastPrice: 69000,
      highPrice: 71000,
      dailyChange: 2.0,
    ),
    Currency(
      icon: 'assets/eth.png',
      hero: '',
      name: 'Etherium',
      price: 3000,
      sigle: 'ETH',
      lastPrice: 2950,
      highPrice: 3050,
      dailyChange: 1.5,
    ),
    Currency(
      icon: 'assets/cardano.png',
      hero: '',
      name: 'Cardano',
      price: 2000,
      sigle: 'ADA',
      lastPrice: 1980,
      highPrice: 2020,
      dailyChange: 1.0,
    ),
    Currency(
      icon: 'assets/tether.png',
      hero: 'assets/Tether-capa.png',
      name: 'Tether',
      price: 1500,
      sigle: 'THT',
      lastPrice: 1505,
      highPrice: 1510,
      dailyChange: -0.5,
    ),
    Currency(
      icon: 'assets/doge.png',
      hero: '',
      name: 'Doge',
      price: 500,
      sigle: 'DOG',
      lastPrice: 510,
      highPrice: 515,
      dailyChange: -2.0,
    ),
    Currency(
      icon: 'assets/plkadot.png',
      hero: '',
      name: 'Polkadot',
      price: 550,
      sigle: 'POL',
      lastPrice: 540,
      highPrice: 560,
      dailyChange: 1.8,
    ),
  ];
}


  // sort() {
  //   if (!isSorted) {
  //     table.sort((Currency a, Currency b) => a.price.compareTo(b.price));
  //     isSorted = true;
  //   } else {
  //     table = table.reversed.toList();
  //   }
  // }


