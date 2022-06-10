import 'package:flutter/material.dart';
import '../widget/navigation_drawer_widget.dart';
import '../widget/new_meal_form.dart';

class NewMealPage extends StatelessWidget {
  const NewMealPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Új étkezés hozzáadása'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: const NewMealForm(),
    );
  }
}
