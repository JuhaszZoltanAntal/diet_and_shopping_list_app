import 'package:diet_and_shopping_list_app/model/ingredient.dart';
import 'package:diet_and_shopping_list_app/page/new_meal_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/meal.dart';
import '../widget/meal_card.dart';
import '../widget/navigation_drawer_widget.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({Key? key}) : super(key: key);

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  /*Function deletes a meal from a meals-box*/
  void deleteMeal(Box<dynamic> meals, dynamic mealKey) {
    setState(() {
      meals.delete(mealKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    /*Get opened 'meals' box*/
    var mealsBox = Hive.box('meals');
    /*Get all meals from mealBox*/
    var allMeals = mealsBox.values;

    return Scaffold(
      endDrawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Étkezések'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: allMeals.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: ScrollController(),
                    itemCount: allMeals.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          MealCard(allMeals.elementAt(index), true, deleteMeal,
                              false, () {}),
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Adjon hozzá étkezéseket, hogy azok itt megjelenhessenek és később étrendet generálhasson belőlük!",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewMealPage(),
                            ),
                          );
                        },
                        child: const Text("Kézi hozzáadás")),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Néhány minta étkezés automatikus hozzáadása (20db)",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      List<Meal> twentyMeals = createTwentyMeal();
                      setState(() {
                        for (var element in twentyMeals) {
                          mealsBox.put(element.name, element);
                        }
                      });
                    },
                    child: const Text("Automatikus hozzáadás"),
                  )
                ],
              ),
            ),
    );
  }
}

/*Function which returns with a predefined list of meals*/
List<Meal> createTwentyMeal() {
  Meal meal1 = Meal("danon natúr joghurt 2db", 154,
      [Ingredient("danon natúr joghurt", 2, "db")], false, false, false, true);
  Meal meal2 = Meal(
      "4 tojásos tükörtojás",
      570,
      [
        Ingredient("tojás", 4, "db"),
        Ingredient("teljeskiörlésű toast kenyérszelet", 3, "db"),
        Ingredient("olaj", 15, "ml")
      ],
      true,
      false,
      true,
      false);
  Meal meal3 = Meal(
      "4 tojásos rántotta",
      570,
      [
        Ingredient("tojás", 4, "db"),
        Ingredient("teljeskiörlésű toast kenyérszelet", 3, "db"),
        Ingredient("olaj", 15, "ml")
      ],
      true,
      false,
      true,
      false);
  Meal meal4 = Meal(
      "csirkemell rizzsel",
      562,
      [
        Ingredient("csirkemellfilé", 300, "g"),
        Ingredient("rizs", 50, "g"),
        Ingredient("olaj", 15, "ml")
      ],
      false,
      true,
      false,
      false);
  Meal meal5 = Meal(
      "csirkecomb sültkrumplival",
      836,
      [
        Ingredient("csirkecombfilé", 300, "g"),
        Ingredient("krumpli", 200, "g"),
        Ingredient("olaj", 40, "ml")
      ],
      false,
      true,
      false,
      false);
  Meal meal6 = Meal(
      "alma", 78, [Ingredient("alma", 1, "db")], false, false, false, true);
  Meal meal7 = Meal(
      "körte", 101, [Ingredient("körte", 1, "db")], false, false, false, true);
  Meal meal8 = Meal(
      "instant tésztaleves",
      304,
      [Ingredient("instant tésztaleves", 1, "csomag")],
      false,
      false,
      false,
      true);
  Meal meal9 = Meal("2 pizza szelet", 500,
      [Ingredient("pizza szelet", 2, "db")], false, false, true, true);
  Meal meal10 = Meal("kfc twister menü", 813,
      [Ingredient("kfc twister menü", 1, "db")], false, true, true, false);
  Meal meal11 = Meal("1 tál eper", 150, [Ingredient("eper", 300, "g")], false,
      false, false, true);
  Meal meal12 = Meal(
      "karaj petrezselymes krumplival",
      773,
      [
        Ingredient("karaj", 300, "g"),
        Ingredient("krumpli", 200, "g"),
        Ingredient("olaj", 20, "ml"),
      ],
      false,
      true,
      false,
      false);
  Meal meal13 = Meal(
      "sajtos makaróni",
      550,
      [
        Ingredient("durum tészta", 70, "g"),
        Ingredient("sajt", 70, "g"),
        Ingredient("tejföl", 100, "g"),
      ],
      false,
      true,
      false,
      false);
  Meal meal14 = Meal(
      "csirkemell sültkrumplival",
      839,
      [
        Ingredient("csirkemellfilé", 300, "g"),
        Ingredient("krumpli", 200, "g"),
        Ingredient("olaj", 40, "ml")
      ],
      false,
      true,
      false,
      false);
  Meal meal15 = Meal(
      "müzli mandulatejjel",
      342,
      [Ingredient("müzli", 80, "g"), Ingredient("mandulatej", 400, "ml")],
      true,
      false,
      false,
      false);
  Meal meal16 = Meal(
      "bundás kenyér 2db",
      550,
      [
        Ingredient("tojás", 1, "db"),
        Ingredient("teljeskiörlésű toast kenyérszelet", 2, "db"),
        Ingredient("olaj", 20, "ml"),
      ],
      true,
      false,
      false,
      false);
  Meal meal17 = Meal("palacsinta 3db", 300, [Ingredient("palacsinta", 3, "db")],
      true, false, false, false);
  Meal meal18 = Meal("sajtos crassion", 250,
      [Ingredient("sajtos crassion", 1, "db")], true, false, false, false);
  Meal meal19 = Meal(
      "bolognai spagetti",
      525,
      [
        Ingredient("durum tészta", 190, "g"),
        Ingredient("maggi bolognai spagetti alap", 15, 'g'),
        Ingredient("darált sertéshús", 75, "g"),
        Ingredient("olaj", 10, "ml")
      ],
      false,
      true,
      false,
      false);
  Meal meal20 = Meal(
      "gyros", 600, [Ingredient("gyros", 1, "db")], false, true, true, false);
  return [
    meal1,
    meal2,
    meal3,
    meal4,
    meal5,
    meal6,
    meal7,
    meal8,
    meal9,
    meal10,
    meal11,
    meal11,
    meal12,
    meal13,
    meal14,
    meal15,
    meal16,
    meal17,
    meal18,
    meal19,
    meal20
  ];
}
