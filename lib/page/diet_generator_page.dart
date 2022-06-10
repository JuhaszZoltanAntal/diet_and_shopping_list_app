import 'package:flutter/material.dart';
import '../widget/navigation_drawer_widget.dart';
import '../widget/new_diet_generator_form.dart';

class DietGeneratorPage extends StatelessWidget {
  const DietGeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Étrend Generálás'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: const NewDietGeneratorForm(),
    );
  }
}
