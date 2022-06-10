import 'package:hive/hive.dart';
import 'meal.dart';

part 'diet.g.dart';

@HiveType(typeId: 2)
class Diet extends HiveObject {
  Diet(this.name, this.mealPerDay, this.kcalPerDay, this.monday, this.tuesday,
      this.wednesday, this.thursday, this.friday, this.saturday, this.sunday);

  @HiveField(0)
  late String name;

  @HiveField(1)
  late int mealPerDay;

  @HiveField(2)
  late int kcalPerDay;

  @HiveField(3)
  late List<Meal> monday;

  @HiveField(4)
  late List<Meal> tuesday;

  @HiveField(5)
  late List<Meal> wednesday;

  @HiveField(6)
  late List<Meal> thursday;

  @HiveField(7)
  late List<Meal> friday;

  @HiveField(8)
  late List<Meal> saturday;

  @HiveField(9)
  late List<Meal> sunday;
}
