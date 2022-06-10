import 'package:hive/hive.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 0)
class Ingredient {
  Ingredient(this.name, this.quantity, this.unit);

  @HiveField(0)
  late String name;

  @HiveField(1)
  late int quantity;

  @HiveField(2)
  late String unit;
}
