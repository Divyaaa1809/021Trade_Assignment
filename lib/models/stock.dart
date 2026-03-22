import 'package:hive/hive.dart';

part 'stock.g.dart';

@HiveType(typeId: 0)
class Stock extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String exchange;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final double change;

  Stock({
    required this.name,
    required this.exchange,
    required this.price,
    required this.change,
  });
}