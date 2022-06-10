import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
    this.dietKcalPerDay,
    this.expectedKcalPerDay,
    this.nameOfDiet,
  );

  final int dietKcalPerDay;
  final int expectedKcalPerDay;
  final String nameOfDiet;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 8),
      shape: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Az étrend neve:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' ${widget.nameOfDiet}'),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Tervezett napi bevitel:',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(text: ' ${widget.expectedKcalPerDay} kcal'),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Jelenlegi étrend szerinti napi bevitel:',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(text: ' ${widget.dietKcalPerDay} kcal'),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: (widget.dietKcalPerDay < widget.expectedKcalPerDay)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: RichText(
                        text: TextSpan(
                          text: 'Az étrend ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${widget.expectedKcalPerDay - widget.dietKcalPerDay} kalóriával kevesebbet',
                              style: const TextStyle(color: Colors.green),
                            ),
                            const TextSpan(
                                text: ' tartalmaz a tervezett bevitelnél, '),
                            const TextSpan(
                              text: 'próbáljon meg többet enni!',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: RichText(
                        text: TextSpan(
                          text: 'Az étrend ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${((widget.expectedKcalPerDay - widget.dietKcalPerDay) * (-1))} kalóriával többet tartalmaz',
                              style: const TextStyle(color: Colors.pinkAccent),
                            ),
                            const TextSpan(text: ' a tervezett bevitelnél, '),
                            const TextSpan(
                              text: 'próbáljon meg kevesebbet enni!',
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}