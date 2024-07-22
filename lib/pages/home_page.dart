import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_estudo_1/repository/currency_repository.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final table = CurrencyRepository.table;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Cripto Currency"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int currency) {
            return ListTile(
              leading: Image.asset(table[currency].icon,),
              title: Text(table[currency].name, style: TextStyle(fontSize: 20)),
              trailing: Text("USD ${table[currency].price.toString()}", style: TextStyle(fontSize: 20 , color: Colors.amberAccent),),
              );
              
          },
          padding: EdgeInsets.all(16),
          separatorBuilder: (_, __) => Divider(),
          itemCount: CurrencyRepository.table.length),
    );
  }
}
