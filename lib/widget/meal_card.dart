import 'package:basic_utils/basic_utils.dart';
import 'package:diet_and_shopping_list_app/widget/meal_type_bubble.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/meal.dart';

class MealCard extends StatefulWidget {
  const MealCard(this.meal, this.isDeleteButton, this.deleteMeal,
      this.isReplaceButton, this.replaceMeal,
      [this.index, this.week, this.mealName]);

  final bool isDeleteButton;
  final Meal meal;
  final Function deleteMeal;
  final bool isReplaceButton;
  final Function replaceMeal;
  final int? index;
  final String? week;
  final String? mealName;

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  late bool customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    var meals = Hive.box('meals');
    return Card(
      key: ValueKey<String>(widget.meal.name),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2, top: 4),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: widget.isDeleteButton
            ? BorderSide(color: Color(0xffFFBE5A), width: 1.5)
            : BorderSide(color: Color(0xff3949AB), width: 1.5),
      ),
      child: ExpansionTile(
        trailing: Icon(
          !customTileExpanded
              ? Icons.arrow_circle_down_outlined
              : Icons.arrow_circle_up_outlined,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() => customTileExpanded = expanded);
        },
        expandedAlignment: Alignment.centerLeft,
        title: Text(
          StringUtils.capitalize(widget.meal.name),
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
                  "Hozzávalók:",
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
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                  "${widget.meal.ingredients[index].name}: "),
                            ),
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
                  child: Wrap(
                    runSpacing: 3,
                    children: [
                      (widget.meal.breakfast
                          ? const MealTypeBubble("Reggeli")
                          : SizedBox()),
                      (widget.meal.lunch
                          ? const MealTypeBubble("Ebéd")
                          : SizedBox()),
                      (widget.meal.dinner
                          ? const MealTypeBubble("Vacsora")
                          : SizedBox()),
                      (widget.meal.otherMeal
                          ? const MealTypeBubble("Egyéb étkezés")
                          : SizedBox()),
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
                    : Container()),
                (widget.isReplaceButton
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.replaceMeal(
                                widget.index, widget.week, widget.mealName);
                          },
                          child: const Text("Étkezés kicserélése"),
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
