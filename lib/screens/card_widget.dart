import 'package:flutter/material.dart';
import 'package:hvac_calc/main.dart';
import 'package:hvac_calc/screens/psychrometric_calculator.dart';

List dataColor = [
  {"color": AppTheme.colors.card},
  // {"color": const Color.fromARGB(255, 213, 93, 13)},
  // {"color": const Color.fromARGB(255, 189, 134, 97)},
];

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
          itemCount: dataColor.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: const Color.fromARGB(0, 189, 134, 97),
                color: AppTheme.colors.card,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PsychrometricCalculator()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.topRight,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.0)),
                            child: Icon(
                              Icons.percent,
                              color: AppTheme.colors.font1,
                              size: 30,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.bottomRight,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.0)),
                            child: Text(
                              'Psychrometric calculator',
                              style: TextStyle(
                                color: AppTheme.colors.font1,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
