import 'package:basic_utils/basic_utils.dart';
import 'package:diet_and_shopping_list_app/helper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widget/navigation_drawer_widget.dart';
import 'diet_generator_page.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    /*Get opened 'shoppingList' box*/
    var shoppingListBox = Hive.box('shoppingList');
    /*Get theShoppingList from shoppingListBox*/
    var theShoppingList = shoppingListBox.get('theShoppingList');

    var sortedList = theShoppingList?.shoppingList ?? [];
    sortedList.sort((a, b) => a.name.toString().compareTo(b.name.toString()));

    return Scaffold(
      endDrawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Bevásárlólista'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: (theShoppingList != null)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 2, top: 10),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    '${StringUtils.capitalize(sortedList[index].name)}: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                  '${Helper().UnitFormat(sortedList[index].unit.toString(), sortedList[index].quantity)} '),
                            ],
                          ),
                        ),
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
                children: [
                  Text(
                    "Még nincs legenerált étrend amiből bevásárlólista készülhetne!",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DietGeneratorPage(),
                          ),
                        );
                      },
                      child: Text("Étrend Generálása"))
                ],
              ),
            ),
    );
  }
}
