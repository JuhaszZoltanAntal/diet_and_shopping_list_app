import "dart:math";

import 'package:diet_and_shopping_list_app/model/shopping_list.dart';
import 'package:diet_and_shopping_list_app/page/new_meal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../model/diet.dart';
import '../model/ingredient.dart';
import '../model/meal.dart';

class NewDietGeneratorForm extends StatefulWidget {
  const NewDietGeneratorForm({Key? key}) : super(key: key);

  @override
  State<NewDietGeneratorForm> createState() => _NewDietGeneratorFormState();
}

class _NewDietGeneratorFormState extends State<NewDietGeneratorForm> {
  final dietFormKey = GlobalKey<FormState>();

  /* Drop down options*/
  List<String> dropDownItems = ['3', '4', '5', '6'];
  String selectedItem = '3';

  /* Form field states*/
  late String name;
  late int kcalPerDay;
  late int mealsPerDay;

  @override
  Widget build(BuildContext context) {
    /*Get opened 'diet' box*/
    var dietBox = Hive.box('diet');
    /*Get opened 'shoppingList' box*/
    var shoppingListBox = Hive.box('shoppingList');
    /*Get opened 'meals' box*/
    var meals = Hive.box('meals');

    /*Get all types of meals in separated lists*/
    var allBreakfast =
        meals.values.where((item) => item.breakfast == true).toList();
    var allLunch = meals.values.where((item) => item.lunch == true).toList();
    var allDinner = meals.values.where((item) => item.dinner == true).toList();
    var allOtherMeal =
        meals.values.where((item) => item.otherMeal == true).toList();

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: dietFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (String? value) {
                  name = value!;
                },
                decoration: const InputDecoration(
                  labelText: 'Adja meg az étrend nevét:',
                  hintText: '1800 kalóriás diéta',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kötelező kitölteni a mezőt!';
                  }
                  return null;
                },
              ),
              TextFormField(
                  onSaved: (String? value) {
                    kcalPerDay = int.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'\d'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Adja meg a napi kalória igényét:',
                    hintText: 'pl.: 1800',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kötelező kitölteni a mezőt, egész számmal!';
                    }
                    return null;
                  }),
              DropdownButtonFormField<String>(
                onSaved: (String? value) {
                  mealsPerDay = int.parse(value!);
                },
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Adja meg hányszor étkezne egy nap:',
                  contentPadding: EdgeInsets.symmetric(vertical: 9),
                ),
                value: selectedItem,
                items: dropDownItems
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (item) => setState(() => {selectedItem = item!}),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    if (dietFormKey.currentState!.validate()) {
                      dietFormKey.currentState?.save();

                      /*Fill up days list*/
                      List<List<Meal>>? days = generateDaysList(
                          allBreakfast,
                          allLunch,
                          allDinner,
                          allOtherMeal,
                          mealsPerDay,
                          context);

                      /*Put a "the diet" in the diet box*/
                      if (days != null) {
                        dietBox.put(
                            'theDiet',
                            Diet(
                                name,
                                mealsPerDay,
                                kcalPerDay,
                                days[0],
                                days[1],
                                days[2],
                                days[3],
                                days[4],
                                days[5],
                                days[6]));

                        /*Create shopping list based on the generated diet*/
                        var theDiet = dietBox.get('theDiet');
                        List<Ingredient> allIngredients =
                            getAllIngredientsFromTheDiet(theDiet);
                        List<Ingredient> shoppingList =
                            createShoppingList(allIngredients);

                        /*Put a "the shopping list" in the shopping list box*/
                        shoppingListBox.put(
                            'theShoppingList', ShoppingList(shoppingList));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Sikeres étrend és vásárló lista generálás!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0xff1FB18F),
                          ),
                        );
                        /*Reset form*/
                        dietFormKey.currentState?.reset();
                        selectedItem = '3';
                      }
                    } else {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                          content: const Text('Töltse ki az összes mezőt!'),
                          backgroundColor: Color(0xffF0588B),
                          contentTextStyle:
                              const TextStyle(color: Colors.white),
                          actions: [
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .clearMaterialBanners();
                              },
                              child: const Text(
                                'Értem',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Étrend generálás'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*Get a random element as Meal from a List*/
Meal getRandomMeal<T>(List<dynamic> list) {
  final random = Random();
  var i = random.nextInt(list.length);
  return list[i] as Meal;
}

/*Generates a list with a list of meals for the week's days if possible or show an error message*/
List<List<Meal>>? generateDaysList(allBreakfast, allLunch, allDinner, allOtherMeal, mealsPerDay, context) {
  late List<Meal> mondayList = [];
  late List<Meal> tuesdayList = [];
  late List<Meal> wednesdayList = [];
  late List<Meal> thursdayList = [];
  late List<Meal> fridayList = [];
  late List<Meal> saturdayList = [];
  late List<Meal> sundayList = [];
  List<List<Meal>> days = [
    mondayList,
    tuesdayList,
    wednesdayList,
    thursdayList,
    fridayList,
    saturdayList,
    sundayList
  ];

  if (allBreakfast.isNotEmpty ||
      allLunch.isNotEmpty ||
      allDinner.isNotEmpty ||
      allOtherMeal.isNotEmpty) {
    if (mealsPerDay == 3) {
      for (var i = 0; i <= days.length - 1; i++) {
        days[i].add(getRandomMeal(allBreakfast));
        days[i].add(getRandomMeal(allLunch));
        days[i].add(getRandomMeal(allDinner));
      }
    } else if (mealsPerDay == 4) {
      for (var i = 0; i <= days.length - 1; i++) {
        days[i].add(getRandomMeal(allBreakfast));
        days[i].add(getRandomMeal(allOtherMeal));
        days[i].add(getRandomMeal(allLunch));
        days[i].add(getRandomMeal(allDinner));
      }
    } else if (mealsPerDay == 5) {
      for (var i = 0; i <= days.length - 1; i++) {
        days[i].add(getRandomMeal(allBreakfast));
        days[i].add(getRandomMeal(allOtherMeal));
        days[i].add(getRandomMeal(allLunch));
        days[i].add(getRandomMeal(allOtherMeal));
        days[i].add(getRandomMeal(allDinner));
      }
    } else {
      for (var i = 0; i <= days.length - 1; i++) {
        days[i].add(getRandomMeal(allBreakfast));
        days[i].add(getRandomMeal(allOtherMeal));
        days[i].add(getRandomMeal(allLunch));
        days[i].add(getRandomMeal(allOtherMeal));
        days[i].add(getRandomMeal(allOtherMeal));
        days[i].add(getRandomMeal(allDinner));
      }
    }
    return days;
  } else {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Text('Adjon meg mindenféle típusú étkezést!'),
        backgroundColor: Colors.pinkAccent,
        contentTextStyle: const TextStyle(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewMealPage(),
                ),
              );
            },
            child: const Text(
              'Étkezések hozzáadása',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
    return null;
  }
}

/*Function which makes a map from S iterable grouped by T*/
Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}

/*Get all the Ingredients from an entire Diet object*/
List<Ingredient> getAllIngredientsFromTheDiet(var theDiet) {
  List<Ingredient> allIngredients = [];
  if (theDiet == null) {
    return allIngredients;
  } else {
    for (int i = 0; i <= theDiet.monday.length - 1; i++) {
      for (int y = 0; y <= theDiet.monday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.monday[i].ingredients[y]);
      }
    }
    for (int i = 0; i <= theDiet.tuesday.length - 1; i++) {
      for (int y = 0; y <= theDiet.tuesday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.tuesday[i].ingredients[y]);
      }
    }

    for (int i = 0; i <= theDiet.wednesday.length - 1; i++) {
      for (int y = 0; y <= theDiet.wednesday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.wednesday[i].ingredients[y]);
      }
    }

    for (int i = 0; i <= theDiet.thursday.length - 1; i++) {
      for (int y = 0; y <= theDiet.thursday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.thursday[i].ingredients[y]);
      }
    }

    for (int i = 0; i <= theDiet.friday.length - 1; i++) {
      for (int y = 0; y <= theDiet.friday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.friday[i].ingredients[y]);
      }
    }

    for (int i = 0; i <= theDiet.saturday.length - 1; i++) {
      for (int y = 0; y <= theDiet.saturday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.saturday[i].ingredients[y]);
      }
    }
    for (int i = 0; i <= theDiet.sunday.length - 1; i++) {
      for (int y = 0; y <= theDiet.sunday[i].ingredients.length - 1; y++) {
        allIngredients.add(theDiet.sunday[i].ingredients[y]);
      }
    }
    return allIngredients;
  }
}

/*Creates a Shopping list from an Ingredients list (groups the same type of ingredients and sum the quantities of them)*/
List<Ingredient> createShoppingList(List<Ingredient> allIngredients) {
  final groups = groupBy(allIngredients, (Ingredient i) {
    return '${i.name}+${i.unit}';
  });

  List<Ingredient> shoppingList = [];

  groups.forEach((k, v) {
    String name = k.split("+")[0];
    String unit = k.split("+")[1];

    int sum = v
        .map((item) => item.quantity)
        .reduce((value, current) => value + current);

    shoppingList.add(Ingredient(name, sum, unit));
  });

  return shoppingList;
}
