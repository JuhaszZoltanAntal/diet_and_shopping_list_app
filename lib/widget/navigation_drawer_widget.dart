import 'package:diet_and_shopping_list_app/page/meals_page.dart';
import 'package:diet_and_shopping_list_app/page/shopping_list_page.dart';
import 'package:flutter/material.dart';
import '../page/diet_page.dart';
import '../page/new_meal_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  /*menu item in the navigationDrawer*/
  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  /*Function which swiches between pages*/
  void selectedItem(BuildContext context, String page) {
    switch (page) {
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
        color: Colors.blue,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Étrend',
                icon: Icons.fastfood_outlined,
                onClicked: () => selectedItem(context, 'diet'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Bevásárló lista',
                icon: Icons.list_alt_sharp,
                onClicked: () => selectedItem(context, 'shopping list'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Új étkezés hozzáadása',
                icon: Icons.add,
                onClicked: () => selectedItem(context, 'new meal'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 48,
              child: buildMenuItem(
                text: 'Étkezések',
                icon: Icons.set_meal_outlined,
                onClicked: () => selectedItem(context, 'meals'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}
