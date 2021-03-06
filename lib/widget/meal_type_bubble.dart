import 'package:flutter/material.dart';

class MealTypeBubble extends StatelessWidget {
  const MealTypeBubble(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xffFFBE5A),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
