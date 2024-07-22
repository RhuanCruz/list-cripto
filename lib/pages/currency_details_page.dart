import 'package:flutter/material.dart';
import 'package:flutter_estudo_1/models/currency.dart';

class CurrencyDetailsPage extends StatefulWidget {
  Currency currency;

  CurrencyDetailsPage({super.key, required this.currency});

  @override
  State<CurrencyDetailsPage> createState() => _CurrencyDetailsPageState();
}

class _CurrencyDetailsPageState extends State<CurrencyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.currency.name
          ),
      ),
    );
  }
}
