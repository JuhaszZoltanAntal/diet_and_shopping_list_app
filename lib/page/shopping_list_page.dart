import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widget/navigation_drawer_widget.dart';

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

    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Bevásárló lista'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: (theShoppingList != null)
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: theShoppingList.shoppingList.length,
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
                              Text(
                                  '${theShoppingList.shoppingList[index].name}: ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  '${theShoppingList.shoppingList[index].quantity.toString()} '),
                              Text(
                                  '${theShoppingList.shoppingList[index].unit} '),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Még nincs legenerált étrend amiből vásárló lista készülhetne!",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
