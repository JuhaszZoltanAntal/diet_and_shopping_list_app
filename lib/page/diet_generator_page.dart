import 'package:flutter/material.dart';

import '../widget/navigation_drawer_widget.dart';
import '../widget/new_diet_generator_form.dart';

class DietGeneratorPage extends StatelessWidget {
  const DietGeneratorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Étrend Generálás'),
        centerTitle: true,
        backgroundColor: const Color(0xff3949AB),
      ),
      body: const NewDietGeneratorForm(),
    );
  }
}
