import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:diet_and_shopping_list_app/page/diet_generator_page.dart';
import 'package:diet_and_shopping_list_app/widget/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/diet.dart';
import '../model/meal.dart';
import '../widget/meal_card.dart';
import '../widget/navigation_drawer_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  /*Shows which day selected from the widgetOptions*/
  int selectedIndex = 0;

  /*Replace a Meal in the Diet*/
  void replaceMeal(int index, String week, String mealName) {
    var mealsBox = Hive.box('meals');
    var allMeals = mealsBox.values;
    List<String> allMealsNames = [];
    for (var element in allMeals) {
      allMealsNames.add(element.name);
    }
    GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("A(z) $mealName kicserélése!"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text(
                        'Keressen a meglévő étkezések közül, és cserélje ki az étkezést!'),
                    SimpleAutoCompleteTextField(
                      key: key,
                      suggestions: allMealsNames,
                      clearOnSubmit: true,
                      textSubmitted: (text) => setState(() {
                        if (allMealsNames.contains(text)) {
                          var dietBox = Hive.box('diet');
                          var theDiet = dietBox.get('theDiet');
                          var selectedMeal = mealsBox.get(text);
                          setState(() {
                            switch (week) {
                              case "monday":
                                {
                                  theDiet.monday[index] = selectedMeal;
                                }
                                break;
                              case "tuesday":
                                {
                                  theDiet.tuesday[index] = selectedMeal;
                                }
                                break;
                              case "wednesday":
                                {
                                  theDiet.wednesday[index] = selectedMeal;
                                }
                                break;
                              case "thursday":
                                {
                                  theDiet.thursday[index] = selectedMeal;
                                }
                                break;
                              case "friday":
                                {
                                  theDiet.friday[index] = selectedMeal;
                                }
                                break;
                              case "saturday":
                                {
                                  theDiet.saturday[index] = selectedMeal;
                                }
                                break;
                              case "sunday":
                                {
                                  theDiet.sunday[index] = selectedMeal;
                                }
                                break;
                              default:
                                {}
                            }
                            theDiet.save();
                          });
                          Navigator.of(context).pop();
                        }
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Vissza'))
              ],
            ));
  }

  /*Function that sums app the calories of the meals per day*/
  int sumCaloriesPerDay(List<Meal> mealList) {
    int sum = 0;
    for (int i = 0; i <= mealList.length - 1; i++) {
      sum += mealList[i].kcal;
    }
    return sum;
  }

  /*Function that returns widgets which are representing the meals of the days of a diet*/
  List<Widget> widgetOptions(Diet theDiet) {
    return <Widget>[
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.monday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.monday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "monday",
                        theDiet.monday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.tuesday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.tuesday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "tuesday",
                        theDiet.tuesday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.wednesday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.wednesday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "wednesday",
                        theDiet.wednesday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.thursday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.thursday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "thursday",
                        theDiet.thursday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.friday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.friday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "friday",
                        theDiet.friday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.saturday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.saturday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "saturday",
                        theDiet.saturday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      Column(
        children: [
          Dashboard(
            sumCaloriesPerDay(theDiet.sunday),
            theDiet.kcalPerDay,
            theDiet.name,
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController(),
              itemCount: theDiet.mealPerDay,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    MealCard(
                        theDiet.sunday[index],
                        false,
                        () {},
                        true,
                        replaceMeal,
                        index,
                        "sunday",
                        theDiet.sunday[index].name),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ];
  }

  /*Function switches between the days of the diet*/
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*Get opened 'diet' box*/
    var dietBox = Hive.box('diet');
    /*Get theDiet from dietBox*/
    var theDiet = dietBox.get('theDiet');

    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Étrend'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          Container(
              width: 110,
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DietGeneratorPage(),
                      ),
                    );
                  },
                  child: const Text("Új Étrend Generálása",
                      textAlign: TextAlign.center))),
        ],
      ),
      body: theDiet != null
          ? widgetOptions(theDiet)[selectedIndex]
          : const Center(
              child: Text(
                "Még nincs legenerált étrend!",
                textAlign: TextAlign.center,
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.h),
            label: 'HÉ',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.k),
            label: 'KE',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.s),
            label: 'SZE',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.c),
            label: 'CSÜ',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.p),
            label: 'PÉ',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.s),
            label: 'SZO',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.v),
            label: 'VA',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        // Fixed
        backgroundColor: Colors.green,
        // <-- This works for fixed
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.blue[800],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
        unselectedIconTheme: const IconThemeData(opacity: 0.0, size: 0),
      ),
    );
  }
}
