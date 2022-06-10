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
                    MealCard(theDiet.monday[index], false, () {}),
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
                    MealCard(theDiet.tuesday[index], false, () {}),
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
                    MealCard(theDiet.wednesday[index], false, () {}),
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
                    MealCard(theDiet.thursday[index], false, () {}),
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
                    MealCard(theDiet.friday[index], false, () {}),
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
                    MealCard(theDiet.saturday[index], false, () {}),
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
                    MealCard(theDiet.sunday[index], false, () {}),
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
