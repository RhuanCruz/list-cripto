import 'package:flutter_estudo_1/models/currency.dart';
import 'package:hive/hive.dart';

class CurrencyHiveAdapter extends TypeAdapter<Currency> {
  @override
  final typeId = 0;

  @override
  Currency read(BinaryReader reader) {
    return Currency(
        icon: reader.readString(),
        name: reader.readString(),
        hero: reader.readString(),
        sigle: reader.readString(),
        price: reader.readDouble(),
        lastPrice: reader.readDouble(),
        highPrice: reader.readDouble(),
        dailyChange: reader.readDouble());
  }

  @override
  void write(BinaryWriter writer, Currency currency) {
    writer.writeString(currency.icon);
    writer.writeString(currency.name);
    writer.writeString(currency.hero);
    writer.writeString(currency.sigle);
    writer.writeDouble(currency.price);
    writer.writeDouble(currency.lastPrice);
    writer.writeDouble(currency.highPrice);
    writer.writeDouble(currency.dailyChange);
  }
}
