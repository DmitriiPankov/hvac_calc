import 'package:flutter/material.dart';
import 'package:hvac_calc/main.dart';
import 'package:hvac_calc/screens/psychrometric_calculator.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

@override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 5.0,
            ),
            Padding (
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PsychrometricCalculator()),);
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppTheme.colors.results,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                    Icons.percent,
                                    color: AppTheme.colors.font1,
                                    size: 26,
                                  ),
                              ),
                              Text(
                                'Psychrometric calculator',
                                style: TextStyle(
                                    fontFamily: 'RobotoMono',
                                    color: AppTheme.colors.font1,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),                           
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '',
                            style: Theme.of(context).textTheme.displayMedium,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        )
    );
  }
}
