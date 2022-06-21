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
  int countOfPerson = 1;

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
        backgroundColor: const Color(0xff3949AB),
      ),
      body: (theShoppingList != null)
          ? Column(
        children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1.5, color: Color(0xffAC48A5)),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.indigo),
                        onPressed: () {
                          if (countOfPerson >= 2) {
                            setState(() {
                              countOfPerson -= 1;
                            });
                          }
                        },
                      ),
                      Text(
                        'Bevásárlás $countOfPerson ember részére',
                        style: const TextStyle(color: Color(0xffAC48A5)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.indigo),
                        onPressed: () {
                          setState(() {
                            countOfPerson += 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sortedList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 4, top: 4),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xffFFBE5A), width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    '${StringUtils.capitalize(sortedList[index].name)}: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1FB18F))),
                              ),
                              Text(
                                  '${Helper().unitFormat(sortedList[index].unit.toString(), (sortedList[index].quantity * countOfPerson))} '),
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
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
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
                      child: const Text("Étrend Generálása"))
                ],
        ),
      ),
    );
  }
}
