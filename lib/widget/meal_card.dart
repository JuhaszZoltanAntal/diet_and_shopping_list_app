import 'package:diet_and_shopping_list_app/widget/meal_type_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/meal.dart';

class MealCard extends StatefulWidget {
  const MealCard(this.meal, this.isDeleteButton, this.deleteMeal);

  final bool isDeleteButton;
  final Meal meal;
  final Function deleteMeal;

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    var meals = Hive.box('meals');
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2, top: 4),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 1)),
      child: ExpansionTile(
        expandedAlignment: Alignment.centerLeft,
        title: Text(
          widget.meal.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${widget.meal.kcal} kcal"),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Összetevők:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.meal.ingredients.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text("- ${widget.meal.ingredients[index].name}: "),
                            Text("${widget.meal.ingredients[index].quantity} "),
                            Text(widget.meal.ingredients[index].unit),
                          ],
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "Étkezés típusa:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      (widget.meal.breakfast
                          ? const MealTypeBubble("Reggeli")
                          : Container()),
                      (widget.meal.lunch
                          ? const MealTypeBubble("Ebéd")
                          : Container()),
                      (widget.meal.dinner
                          ? const MealTypeBubble("Vacsora")
                          : Container()),
                      (widget.meal.otherMeal
                          ? const MealTypeBubble("Egyéb étkezés")
                          : Container()),
                    ],
                  ),
                ),
                (widget.isDeleteButton
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.deleteMeal(meals, widget.meal.name);
                          },
                          child: const Text("Étkezés törlése"),
                        ),
                      )
                    : Container())
              ],
            ),
          )
        ],
      ),
    );
  }
}