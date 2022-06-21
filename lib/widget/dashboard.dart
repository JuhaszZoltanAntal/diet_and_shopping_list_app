import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
    this.dietKcalPerDay,
    this.expectedKcalPerDay,
    this.dietKcalPerWeek,
    this.expectedKcalPerWeek,
    this.mealPerDay,
    this.nameOfDiet,
  );

  final int dietKcalPerDay;
  final int expectedKcalPerDay;
  final int dietKcalPerWeek;
  final int expectedKcalPerWeek;
  final int mealPerDay;
  final String nameOfDiet;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 3, top: 8),
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xffFFBE5A), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 9, bottom: 9),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Alap adatok:\n',
                      style: TextStyle(
                          color: Color(0xff3949AB),
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            '\u2022 Étrend neve: ${StringUtils.capitalize(widget.nameOfDiet)}\n\u2022 Tervezett napi bevitel: ${widget.expectedKcalPerDay} kalória\n\u2022 Étkezések száma naponta: ${widget.mealPerDay}'),
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
                      text: 'Heti egyenleg:',
                      style: TextStyle(
                          color: Color(0xff3949AB),
                          fontWeight: FontWeight.bold),
                    ),
                    widget.expectedKcalPerWeek - widget.dietKcalPerWeek < 0
                        ? TextSpan(
                            text:
                                ' ${(widget.expectedKcalPerWeek - widget.dietKcalPerWeek) * -1} kalóriával több',
                            style: const TextStyle(
                              color: Color(0xffF0588B),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : TextSpan(
                            text:
                                ' ${widget.expectedKcalPerWeek - widget.dietKcalPerWeek} kalóriával kevesebb',
                            style: const TextStyle(
                              color: Color(0xff1FB18F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      text: 'Napi egyenleg:',
                      style: TextStyle(
                          color: Color(0xff3949AB),
                          fontWeight: FontWeight.bold),
                    ),
                    widget.expectedKcalPerDay - widget.dietKcalPerDay < 0
                        ? TextSpan(
                            text:
                                ' ${(widget.expectedKcalPerDay - widget.dietKcalPerDay) * -1} kalóriával több',
                            style: const TextStyle(
                              color: Color(0xffF0588B),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : TextSpan(
                            text:
                                ' ${widget.expectedKcalPerDay - widget.dietKcalPerDay} kalóriával kevesebb',
                            style: const TextStyle(
                              color: Color(0xff1FB18F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            /* Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'Tervezett napi bevitel:',
                      style: TextStyle(
                          color: Color(0xff3949AB),
                          fontWeight: FontWeight.bold),
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
                      style: TextStyle(
                          color: Color(0xff3949AB),
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' ${widget.dietKcalPerDay} kcal',),
                  ],
                ),
              ),
            ),*/

            /* Align(
              alignment: Alignment.topLeft,
              child: (widget.dietKcalPerDay < widget.expectedKcalPerDay)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: RichText(
                        text: TextSpan(
                          text: 'A napi étrend ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${widget.expectedKcalPerDay - widget.dietKcalPerDay} kalóriával kevesebbet',
                              style: const TextStyle(
                                  color: Color(0xff1FB18F),
                                  fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                                text: ' tartalmaz a tervezett bevitelnél, '),
                            const TextSpan(
                              text: 'próbáljon meg többet enni!',
                              style: TextStyle(
                                  color: Color(0xff1FB18F),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: RichText(
                        text: TextSpan(
                          text: 'A napi étrend ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${((widget.expectedKcalPerDay - widget.dietKcalPerDay) * (-1))} kalóriával többet tartalmaz',
                              style: const TextStyle(
                                  color: Color(0xffF0588B),
                                  fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: ' a tervezett bevitelnél, '),
                            const TextSpan(
                              text: 'próbáljon meg kevesebbet enni!',
                              style: TextStyle(
                                  color: Color(0xffF0588B),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),*/
          ],
        ),
      ),
    );
  }
}
