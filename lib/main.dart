import 'package:diet_and_shopping_list_app/model/diet.dart';
import 'package:diet_and_shopping_list_app/model/ingredient.dart';
import 'package:diet_and_shopping_list_app/model/shopping_list.dart';
import 'package:diet_and_shopping_list_app/page/diet_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/meal.dart';

Future<void> main() async {
  /*Init flutter hive*/
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(IngredientAdapter());
  Hive.registerAdapter(DietAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  await Hive.openBox('meals');
  await Hive.openBox('ingredients');
  await Hive.openBox('diet');
  await Hive.openBox('shoppingList');
  /*Entry point*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet and Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xffFAF8FF),
        errorColor: Color(0xffF0588B),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xffAC48A5),
            ),
            //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ), //text (and icon)
          ),
        ),
      ),
      home: const DietPage(),
    );
  }
}
