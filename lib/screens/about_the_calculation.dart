import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hvac_calc/main.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:hvac_calc/information_text_si.dart';
import 'package:hvac_calc/information_text_ip.dart';

int? initialIndexAbout = 0;
var labelAbout1 = 0;
var labelAbout2 = 1;

// Widgets for formulas, texts, subscripts and superscripts

// Widget for blue Headline
  Widget myBlueHeadline(String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(
          backgroundColor: AppTheme.colors.results,
          color: AppTheme.colors.font1,
        ),
      ),
    );
  }

  // Widget for blue Headline with subscripts
  Widget myBlueHeadlineSub(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          color: AppTheme.colors.results,
          child: EasyRichText(
            text,
            
            defaultStyle: TextStyle(color: AppTheme.colors.font1),
            patternList: [
              EasyRichTextPattern(
                stringBeforeTarget: 'lb',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'da',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'lb',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'w',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'kg',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'da',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'kg',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'w',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'W',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 's',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'P',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'ws',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              // EasyRichTextPattern(
              //   matchOption: 'last',
              //   stringBeforeTarget: 'P',
              //   matchWordBoundaries: false,
              //   subScript: true,
              //   targetString: 'a',
              //   style: TextStyle(color: AppTheme.colors.font1),
              // ),
              EasyRichTextPattern(
                stringBeforeTarget: 'P',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'w',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                matchWordBoundaries: false,
                targetString: 'ϕ',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                matchOption: 'last',
                stringBeforeTarget: 't',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'd',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'm',
                matchWordBoundaries: false,
                superScript: true,
                targetString: '3',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
              EasyRichTextPattern(
                stringBeforeTarget: 'ft',
                matchWordBoundaries: false,
                superScript: true,
                targetString: '3',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  // Widget for vertical offset
  Widget myVerticalOffset (double size) {
    return SizedBox(
      height: size,
    );
  }

  // Widget for simple text with left alignment
  Widget mySimpleLeftText (String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 13),),
    );
  }

  // Widget for simple bold and italic text with left alignment
  Widget mySimpleLeftTextHead (String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
    );
  }

  // Widget for simple text with justify alignment
  Widget mySimpleJustifyText (String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.centerLeft,
      child: Text(text, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 13)),
    );
  }

  // Widget for formulas
  Widget myFormula (String formula, String numb) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 10,
        direction: Axis.horizontal,
        children: [
          FittedBox(
            child: Math.tex(
                  formula,
                  textStyle: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            '($numb ASHRAE 2021)',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Widget for formulas without number Ashrae
  Widget myFormulaWithoutAshrae (String formula, String numb) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        runSpacing: 10,
        direction: Axis.horizontal,
        children: [
          FittedBox(
            child: Math.tex(
                  formula,
                  textStyle: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            '($numb)',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Widget for formulas with left alignment
  Widget myFormulaLeft (String formula) {
    return Container(
      padding: const EdgeInsets.only(left: 18, bottom: 8),
      alignment: Alignment.centerLeft,
      child: FittedBox(
        child: Math.tex(
              formula,
              textStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  // Widget for formulas where the description is used
  Widget myFormulaWhere (String formula, String text) {
    return Container(
      padding: const EdgeInsets.only(left: 18, bottom: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Math.tex(
                  formula,
                  textStyle: const TextStyle(fontSize: 14),
            ),
            Flexible(
              child: Text(
                  text,
                  style: const TextStyle(fontSize: 13)
              ),
            ),
          ],
        ),
    );
  }

  // Widget for formulas where the description is used with subscripts
  Widget myFormulaWhereSub (String formula, String text) {
    return Container(
      padding: const EdgeInsets.only(left: 18, bottom: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Math.tex(
                  formula,
                  textStyle: const TextStyle(fontSize: 14),
            ),
            Flexible(
              child: EasyRichText(
              defaultStyle: const TextStyle(fontSize: 13),
              text,
              patternList: [
                EasyRichTextPattern(
                  stringBeforeTarget: 'lb',
                  matchWordBoundaries: false,
                  subScript: true,
                  targetString: 'da',
                ),
                EasyRichTextPattern(
                  stringBeforeTarget: 'lb',
                  matchWordBoundaries: false,
                  subScript: true,
                  targetString: 'w',
                ),
                EasyRichTextPattern(
                  stringBeforeTarget: 'kg',
                  matchWordBoundaries: false,
                  subScript: true,
                  targetString: 'da',
                ),
                EasyRichTextPattern(
                  stringBeforeTarget: 'kg',
                  matchWordBoundaries: false,
                  subScript: true,
                  targetString: 'w',
                ),
                EasyRichTextPattern(
                  stringBeforeTarget: 'W',
                  matchWordBoundaries: false,
                  subScript: true,
                  targetString: 's',
                ),
                EasyRichTextPattern(
                  matchOption: 'last',
                  stringBeforeTarget: 'p',
                  matchWordBoundaries: false,
                  subScript: true,
                  targetString: 'w',
                ),
              ],
            ),
            ),
          ],
        ),
    );
  }

class AboutTheCalculation extends StatefulWidget {
  const AboutTheCalculation({super.key});

  @override
  State<AboutTheCalculation> createState() => _InformationState();
}

class _InformationState extends State<AboutTheCalculation> {

  @override
  void initState() {
    super.initState();
    initialIndexAbout = 0;
    labelAbout1 = 0;
    labelAbout2 = 1;
  }

  @override
  void dispose() {
    initialIndexAbout = 0;
    super.dispose();
  }

  // Body of page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color.fromARGB(255, 255, 255, 255), 
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark,   // For Android (dark icons)
          statusBarBrightness: Brightness.light,      // For iOS (dark icons)
        ),
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.colors.font1,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About the calculation',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            color: AppTheme.colors.font1,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
          child: Column(
            children: [

              // Switcher

              ToggleSwitch(
                labels: const ['SI', 'IP'],        
                curve: Curves.easeIn,
                animate: true,
                animationDuration: 400,
                initialLabelIndex: initialIndexAbout,
                totalSwitches: 2,
                minHeight: 28,
                minWidth: 70,
                cornerRadius: 14,
                activeBgColor: [
                  AppTheme.colors.toggle,
                  const Color.fromARGB(150, 64, 179, 255),
                ],
                inactiveBgColor: AppTheme.colors.field,
                radiusStyle: true,
                onToggle: (index) {

                  // from SI to IP

                  if (index == 1 && labelAbout1 == 0) {
                    labelAbout1 = 1;
                    labelAbout2 = 0;
                    initialIndexAbout = 1;
                    setState(() {initialIndexAbout = 1;});
      
                  // from IP to SI
                    
                  } else if (index == 0 && labelAbout2 == 0) {
                    labelAbout1 = 0;
                    labelAbout2 = 1;
                    initialIndexAbout = 0;
                    setState(() {initialIndexAbout = 0;});
                  }
                },
              ),
              
              Builder(
                builder: (context) {
                  if (initialIndexAbout == 0) {
                    return informationTextSi();   // Text for Si from information_text_si.dart
                  } else {
                    return informationTextIp();   // Text for Ip from information_text_ip.dart
                  }
                }
              ),

            ],
          ),
        ),
      ),
    );
  }
}