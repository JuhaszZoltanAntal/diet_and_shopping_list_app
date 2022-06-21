import 'package:diet_and_shopping_list_app/page/meals_page.dart';
import 'package:diet_and_shopping_list_app/page/shopping_list_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../page/diet_generator_page.dart';
import '../page/diet_page.dart';
import '../page/new_meal_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  /*menu item in the navigationDrawer*/
  Widget buildMenuItem({
    required String text,
    required FaIcon icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  /*Function which switches between pages*/
  void selectedItem(BuildContext context, String page) {
    switch (page) {
      case 'generate diet':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DietGeneratorPage(),
          ),
        );
        break;
      case 'diet':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DietPage(),
          ),
        );
        break;
      case 'shopping list':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ShoppingListPage(),
          ),
        );
        break;
      case 'new meal':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NewMealPage(),
          ),
        );
        break;
      case 'meals':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MealsPage(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xff1FB18F),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Étrend generálása',
                icon: const FaIcon(
                  FontAwesomeIcons.gears,
                  color: Colors.white,
                ),
                onClicked: () => selectedItem(context, 'generate diet'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Új étkezés hozzáadása',
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
                onClicked: () => selectedItem(context, 'new meal'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.white70,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Étrend',
                icon: const FaIcon(
                  FontAwesomeIcons.appleWhole,
                  color: Colors.white,
                ),
                onClicked: () => selectedItem(context, 'diet'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Bevásárlólista',
                icon: const FaIcon(
                  FontAwesomeIcons.clipboardList,
                  color: Colors.white,
                ),
                onClicked: () => selectedItem(context, 'shopping list'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Étkezések',
                icon: const FaIcon(
                  FontAwesomeIcons.bowlRice,
                  color: Colors.white,
                ),
                onClicked: () => selectedItem(context, 'meals'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
