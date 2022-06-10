import 'package:hive/hive.dart';
import 'ingredient.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 3)
class ShoppingList extends HiveObject {
  ShoppingList(this.shoppingList);

  @HiveField(0)
  List<Ingredient> shoppingList;
}
