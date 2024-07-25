import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/adapters/currency_adapter.dart';
import 'package:flutter_estudo_1/models/currency.dart';
import 'package:hive/hive.dart';

class FavoriteRepository extends ChangeNotifier {
  final List<Currency> _list = [];
  late LazyBox box;

  FavoriteRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavorites();
  }

  UnmodifiableListView<Currency> get lista => UnmodifiableListView(_list);

  _openBox() async {
    Hive.registerAdapter(CurrencyHiveAdapter());
    box = await Hive.openLazyBox<Currency>('favorites');
  }

  _readFavorites() {
    box.keys.forEach((coin) async {
      Currency c = await box.get(coin);
      _list.add(coin);
      notifyListeners();
    });
  }

  saveAll(List<Currency> coins) {
    coins.forEach((coin) {
      if (!_list.any((atual) => atual.sigle == coin.sigle)) {
        _list.add(coin);
        box.put(coin.sigle, coin);
      }
    });
    notifyListeners();
  }

  remove(Currency currency) {
    _list.remove(currency);
    box.delete(currency.sigle);
    notifyListeners();
  }
}
