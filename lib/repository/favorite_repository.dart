import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/models/currency.dart';

class FavoriteRepository extends ChangeNotifier {
  final List<Currency> _list = [];

  UnmodifiableListView<Currency> get lista => UnmodifiableListView(_list);

  saveAll(List<Currency> coins) {
    for (var coin in coins) {
      if (!_list.contains(coin)) _list.add(coin);
    }
    notifyListeners();
  }

  remove(Currency currency) {
    _list.remove(currency);
    notifyListeners();
  }
}
