import 'package:hive/hive.dart';
import 'ingredient.dart';

part 'meal.g.dart';

@HiveType(typeId: 1)
class Meal extends HiveObject {
  Meal(this.name, this.kcal, this.ingredients, this.breakfast, this.lunch,
      this.dinner, this.otherMeal);

  @HiveField(0)
  late String name;

  @HiveField(1)
  late int kcal;

  @HiveField(2)
  late List<Ingredient> ingredients;

  @HiveField(3)
  late bool breakfast;

  @HiveField(4)
  late bool lunch;

  @HiveField(5)
  late bool dinner;

  @HiveField(6)
  late bool otherMeal;
}
