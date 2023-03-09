import 'package:flutter/material.dart';
import 'package:hvac_calc/screens/about_the_calculation.dart';
import 'main.dart';

// Expanded List #4 Converting Between Systems of Measurement: Imperial and SI-Units

Widget informationTextConv () {
  return ListTileTheme(
    minLeadingWidth: 0,
    child: ExpansionTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      childrenPadding: const EdgeInsets.symmetric(vertical: 10),
      collapsedTextColor: AppTheme.colors.font1,
      tilePadding: const EdgeInsets.only(left: 10, right: 10),
      leading: const Icon(
        Icons.info_outline,
        size: 20,
      ),
      collapsedIconColor: AppTheme.colors.font1,
      collapsedBackgroundColor: AppTheme.colors.toggle,
      expandedAlignment: Alignment.centerLeft,
      title: const Text(
        'Converting Between Systems of Measurement: Imperial and SI-Units',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      children: [
        myBlueHeadline('Temperature:'),
        myFormulaWithoutNum(r't_C=\frac{5}{9} \times (t_F-32)', ''),
        myFormulaWithoutNum(r't_F=\frac{9}{5} \times (t_C+32)', ''),
        mySimpleLeftText('where'),
        myFormulaWhere(r't_C\:-\:', 'Celsius temperature'),
        myFormulaWhere(r't_F\:-\:', 'Fahrenheit temperature'),
        myBlueHeadline('Weight:'),
        mySimpleLeftText('1 kg = 2,20462262185 lb'),
        mySimpleLeftText('1 lb = 0,45359237 kg'),
        myBlueHeadline('Volume:'),
        mySimpleLeftTextSub('1 m3 = 35,31467 ft3'),
        mySimpleLeftTextSub('1 ft3= 0,0283168 m3'),
        myBlueHeadline('Pressure:'),
        mySimpleLeftTextSub('1 Pa = 0,000145038 psia'),
        mySimpleLeftTextSub('1 psia = 0,000145038 Pa'),
        myBlueHeadline('Energy:'),
        mySimpleLeftTextSub('1 kJ = 0,947817 Btu'),
        mySimpleLeftTextSub('1 Btu = 1,05506 kJ'),
      ]
    ),
  );
}