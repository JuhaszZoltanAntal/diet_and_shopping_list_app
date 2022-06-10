import 'package:diet_and_shopping_list_app/model/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../model/meal.dart';

class NewMealForm extends StatefulWidget {
  const NewMealForm({Key? key}) : super(key: key);

  @override
  State<NewMealForm> createState() => _NewMealFormState();
}

class _NewMealFormState extends State<NewMealForm> {
  final formKey = GlobalKey<FormState>();

  /* Drop down options*/
  List<String> dropDownItems = ['db', 'g', 'ml', 'csomag'];
  List<String> selectedItems = ['db'];

  /* Count of the dynamic field*/
  int count = 1;

  /* Form field states*/
  late String name;
  late int kcal;
  late List<Ingredient> ingredientsList = [];
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  bool otherMeal = false;

  @override
  Widget build(BuildContext context) {
    /*Get opened 'meals' box*/
    var mealsBox = Hive.box('meals');

    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
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
                  labelText: 'Adja meg az étkezés nevét:',
                  hintText: 'pl.: 4 tojásos rántotta',
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
                    kcal = int.parse(value!);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'\d')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Adja meg az étkezés kalória tartalmát:',
                    hintText: 'pl.: 400',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kötelező kitölteni a mezőt, egész számmal!';
                    }
                    return null;
                  }),
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: const [
                    Text('Adja meg az étkezés hozzávalóit: '),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      key: Key(index.toString()),
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                onSaved: (String? value) {
                                  ingredientsList
                                      .add(Ingredient("name", 0, "unit"));
                                  ingredientsList[index].name = value!;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Név',
                                  hintText: 'pl.: tojás',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Üres';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                onSaved: (String? value) {
                                  ingredientsList[index].quantity =
                                      int.parse(value!);
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'\d')),
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Mennyiség',
                                  hintText: 'pl.: 4',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Üres';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            onSaved: (String? value) {
                              ingredientsList[index].unit = value!;
                            },
                            decoration: const InputDecoration(
                              isDense: true,
                              labelText: 'Mértékegység',
                              contentPadding: EdgeInsets.symmetric(vertical: 9),
                            ),
                            value: selectedItems[index],
                            items: dropDownItems
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(fontSize: 18),
                                    )))
                                .toList(),
                            onChanged: (item) =>
                                setState(() => {selectedItems[index] = item!}),
                          ),
                        ),
                      ],
                    );
                  }),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            selectedItems.add('db');
                            setState(() {
                              count = count + 1;
                            });
                          },
                          child: const Text('Több összetevő felvétele'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                count > 1 ? count = count - 1 : count = 1;
                              });
                            },
                            child: const Text('Kevesebb összetevő'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Adja meg az étkezés típusát (legalább egyet)'),
                ),
              ),
              CheckboxListTile(
                title: const Text("Reggeli"),
                value: breakfast,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onChanged: (newValue) {
                  setState(() {
                    breakfast = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text("Ebéd"),
                value: lunch,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onChanged: (newValue) {
                  setState(() {
                    lunch = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text("Vacsora"),
                value: dinner,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onChanged: (newValue) {
                  setState(() {
                    dinner = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: const Text("Egyéb napközbeni étkezés"),
                value: otherMeal,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                onChanged: (newValue) {
                  setState(() {
                    otherMeal = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              ElevatedButton(
                onPressed: () {
                  if (otherMeal || dinner || breakfast || lunch) {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState?.save();

                      /*Put a meal in mealsBox*/
                      setState(() {
                        mealsBox.put(
                            name,
                            Meal(name, kcal, ingredientsList, breakfast, lunch,
                                dinner, otherMeal));
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Mentve az étkezásek közé!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );

                      /*Reset form*/
                      formKey.currentState?.reset();
                      otherMeal = false;
                      dinner = false;
                      breakfast = false;
                      lunch = false;
                      count = 1;
                      selectedItems = ['db'];
                      ingredientsList = [];
                    }
                  } else {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        content: const Text(
                            'Úgy tünik nem jelölted meg az étkezés típusát'),
                        backgroundColor: Colors.pinkAccent,
                        contentTextStyle: const TextStyle(color: Colors.white),
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
                child: const Text('Mentés'),
              ),
              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ),
      ),
    );
  }
}
