import 'package:flutter/material.dart';
import 'package:hvac_calc/main.dart';
import 'package:hvac_calc/psychrometric.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PsychrometricCalculator extends StatefulWidget {
  const PsychrometricCalculator({super.key});

  @override
  State<PsychrometricCalculator> createState() => _PsychrometricCalculator();
}

int? initialIndex = 0;

class _PsychrometricCalculator extends State<PsychrometricCalculator> {
  final colorsTheme = Colors.black;

  final textController1 = TextEditingController(text: '101325'); // p
  final textController2 = TextEditingController(text: '0'); // h
  final textController3 = TextEditingController(text: '20.0'); // tdb
  final textController4 = TextEditingController(text: ''); // fi
  final textController5 = TextEditingController(text: ''); // twb
  final textController6 = TextEditingController(text: ''); // tdp

  String namePressure = 'Pressure, Pa';
  String nameAltitude = 'Altitude, m';
  String nameTdb = 'Tdb, °C';
  String nameF = 'f, %';
  String nameTwb = 'Twb, °C';
  String nameTdp = 'Tdp, °C';

  var greenLabel = 0;
  var label1 = 0;
  var label2 = 0;

  @override
  void dispose() {
    initialIndex = 0;
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    textController5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
        title: const Text('Psychrometric calculator'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 5.0,
          ),

          // SI - IP toggle switch

          ToggleSwitch(
            labels: const ['SI', 'IP'],
            customTextStyles: [Theme.of(context).textTheme.displaySmall],
            initialLabelIndex: initialIndex,
            totalSwitches: 2,
            minHeight: 30,
            minWidth: 70,
            cornerRadius: 15,
            activeBgColor: [
              AppTheme.colors.toggle,
              AppTheme.colors.toggle,
            ],
            inactiveBgColor: AppTheme.colors.field,
            radiusStyle: true,
            onToggle: (index) {
              setState(() {
                if (index == 1 && label1 == 0) {
                  namePressure = 'Pressure, in Hg';
                  nameAltitude = 'Altitude, ft';
                  nameTdb = 'Tdb, °F';
                  nameF = 'f, %';
                  nameTwb = 'Twb, °F';
                  nameTdp = 'Tdp, °F';
                  label1 = 1;
                  label2 = 0;

                  // from SI to IP

                  textController1.text =
                      (double.parse(textController1.text) / 1000 * 0.2953)
                          .toStringAsFixed(4);
                  textController2.text =
                      (double.parse(textController2.text) * 3.28)
                          .toStringAsFixed(0);
                  textController3.text =
                      ((double.parse(textController3.text) * 9 / 5) + 32)
                          .toStringAsFixed(1);
                  textController5.text =
                      (((double.parse(textController5.text)) * 9 / 5) + 32)
                          .toStringAsFixed(1);
                  textController6.text =
                      (((double.parse(textController6.text)) * 9 / 5) + 32)
                          .toStringAsFixed(1);

                  // from IP to SI
                } else if (index == 0 && label2 == 0) {
                  namePressure = 'Pressure, Pa';
                  nameAltitude = 'Altitude, m';
                  nameTdb = 'Tdb, °C';
                  nameF = 'f, %';
                  nameTwb = 'Twb, °C';
                  nameTdp = 'Tdp, °C';
                  label2 = 1;
                  label1 = 0;

                  textController1.text =
                      (double.parse(textController1.text) * 1000 / 0.2953)
                          .toStringAsFixed(0);
                  textController2.text =
                      (double.parse(textController2.text) / 3.28)
                          .toStringAsFixed(0);
                  textController3.text =
                      ((double.parse(textController3.text) - 32) * 5 / 9)
                          .toStringAsFixed(1);
                  textController5.text =
                      ((double.parse(textController5.text) - 32) * 5 / 9)
                          .toStringAsFixed(1);
                  textController6.text =
                      ((double.parse(textController6.text) - 32) * 5 / 9)
                          .toStringAsFixed(1);
                }
                initialIndex = index;
              });
            },
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Pressure and Altitude

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        namePressure,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: AppTheme.colors.field,
                        ),

                        // Pressure TextFormField

                        child: TextFormField(
                          controller: textController1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // SI - IP checking
                              if (initialIndex == 0) {
                                textController2.text =
                                    heightFromPressure(double.parse(value))
                                        .toStringAsFixed(0);
                              } else if (initialIndex == 1) {
                                textController2.text = (heightFromPressure(
                                            double.parse(value) *
                                                1000 /
                                                0.2953) *
                                        3.28)
                                    .toStringAsFixed(0);
                              }
                            } else {
                              textController2.text = '';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        nameAltitude,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: AppTheme.colors.field,
                        ),

                        // Altitude TextFormField

                        child: TextFormField(
                          controller: textController2,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // SI - IP checking
                              if (initialIndex == 0) {
                                textController1.text =
                                    pressureFromHeight(double.parse(value))
                                        .toStringAsFixed(0);
                              } else if (initialIndex == 1) {
                                textController1.text = (pressureFromHeight(
                                            double.parse(value) / 3.28) /
                                        1000 *
                                        0.2953)
                                    .toStringAsFixed(4);
                              }
                            } else {
                              textController1.text = '';
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          // Tdb

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                Tooltip(
                  verticalOffset: 11,
                  message: 'Dry bulb temperature',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Text(
                    nameTdb,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: AppTheme.colors.field,
                  ),

                  // Tdb TextFormField

                  child: TextFormField(
                    controller: textController3,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(6),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          // f, Twb, Tdp

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // f

                Flexible(
                  child: Column(
                    children: [
                      Tooltip(
                        verticalOffset: 11,
                        message: 'Relative humidity',
                        triggerMode: TooltipTriggerMode.tap,
                        child: Text(
                          nameF,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: AppTheme.colors.field,
                        ),

                        // f TextFormField

                        child: TextFormField(
                          controller: textController4,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 1;
                            });
                            if (value.isNotEmpty) {
                              // SI - IP checking
                              if (initialIndex == 0) {
                                textController5.text = getTWetBulbFromRelHum(
                                  fi: double.parse(value) / 100,
                                  tdb: double.parse(textController3.text),
                                  p: double.parse(textController1.text),
                                ).toStringAsFixed(1);

                                textController6.text = getTDewPointFromRelHum(
                                  fi: double.parse(value) / 100,
                                  tdb: double.parse(textController3.text),
                                ).toStringAsFixed(1);

                                calcPsychrometricsFromRelHum(
                                  tdb: double.parse(textController3.text),
                                  fi: double.parse(value),
                                  p: double.parse(textController1.text),
                                );
                              } else if (initialIndex == 1) {

                                textController5.text = ((getTWetBulbFromRelHum(
                                  fi: double.parse(value) / 100,
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                ) * 9 / 5) + 32).toStringAsFixed(1);

                                textController6.text = ((getTDewPointFromRelHum(
                                  fi: double.parse(value) / 100,
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                ) * 9 / 5) + 32).toStringAsFixed(1);

                                calcPsychrometricsFromRelHum(
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  fi: double.parse(value),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                );
                              }
                            } else {
                              textController5.text = '';
                              textController6.text = '';
                              outputHR = '';
                              outputV = '';
                              outputMU = '';
                              outputH = '';
                              outputVP = '';
                              outputSVP = '';
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: greenLabel == 1
                                  ? Colors.green
                                  : const Color.fromARGB(0, 244, 67, 54),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),

                // Twb

                Flexible(
                  child: Column(
                    children: [
                      Tooltip(
                        verticalOffset: 11,
                        message: 'Wet bulb temperature',
                        triggerMode: TooltipTriggerMode.tap,
                        child: Text(
                          nameTwb,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: AppTheme.colors.field,
                        ),

                        // Twb TextFormField

                        child: TextFormField(
                          controller: textController5,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 2;
                            });
                            if (value.isNotEmpty) {
                              // SI - IP checking
                              if (initialIndex == 0) {
                                textController6.text = getTDewPointFromTWetBulb(
                                  twb: double.parse(value),
                                  tdb: double.parse(textController3.text),
                                  p: double.parse(textController1.text),
                                ).toStringAsFixed(1);

                                textController4.text = (getRelHumFromTWetBulb(
                                  twb: double.parse(value),
                                  tdb: double.parse(textController3.text),
                                  p: double.parse(textController1.text),
                                ) * 100).toStringAsFixed(1);

                                calcPsychrometricsFromTWetBulb(
                                  tdb: double.parse(textController3.text),
                                  twb: double.parse(value),
                                  p: double.parse(textController1.text),
                                );
                              } else if (initialIndex == 1) {
                                textController6.text = ((getTDewPointFromTWetBulb(
                                  twb: ((double.parse(value) - 32) * 5 / 9),
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                ) * 9 / 5) + 32).toStringAsFixed(1);

                                textController4.text = (getRelHumFromTWetBulb(
                                  twb: ((double.parse(value) - 32) * 5 / 9),
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                ) * 100).toStringAsFixed(1);

                                calcPsychrometricsFromTWetBulb(
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  twb: ((double.parse(value) - 32) * 5 / 9),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                );
                              }
                            } else {
                              textController4.text = '';
                              textController6.text = '';
                              outputHR = '';
                              outputV = '';
                              outputMU = '';
                              outputH = '';
                              outputVP = '';
                              outputSVP = '';
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: greenLabel == 2
                                  ? Colors.green
                                  : const Color.fromARGB(0, 244, 67, 54),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),

                // Tdp

                Flexible(
                  child: Column(
                    children: [
                      Tooltip(
                        verticalOffset: 11,
                        message: 'Dew point temperature',
                        triggerMode: TooltipTriggerMode.tap,
                        child: Text(
                          nameTdp,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: AppTheme.colors.field,
                        ),

                        // Tdp TextFormField

                        child: TextFormField(
                          controller: textController6,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 3;
                            });
                            if (value.isNotEmpty) {
                               // SI - IP checking
                              if (initialIndex == 0) {

                                textController5.text = getTWetBulbFromTDewPoint(
                                  tdp: double.parse(value),
                                  tdb: double.parse(textController3.text),
                                  p: double.parse(textController1.text),
                                ).toStringAsFixed(1);

                                textController4.text = (getRelHumFromTDewPoint(
                                  tdp: double.parse(value),
                                  tdb: double.parse(textController3.text),
                                ) * 100).toStringAsFixed(1);

                                calcPsychrometricsFromTDewPoint(
                                  tdb: double.parse(textController3.text),
                                  tdp: double.parse(value),
                                  p: double.parse(textController1.text),
                                );
                              } else if (initialIndex == 1) {
                                textController5.text = ((getTWetBulbFromTDewPoint(
                                  tdp: ((double.parse(value) - 32) * 5 / 9),
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                ) * 9 / 5) + 32).toStringAsFixed(1);

                                textController4.text = (getRelHumFromTDewPoint(
                                  tdp: ((double.parse(value) - 32) * 5 / 9),
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                ) * 100).toStringAsFixed(1);

                                calcPsychrometricsFromTDewPoint(
                                  tdb: ((double.parse(textController3.text) - 32) * 5 / 9),
                                  tdp: ((double.parse(value) - 32) * 5 / 9),
                                  p: (double.parse(textController1.text) * 1000 / 0.2953),
                                );
                              }
                            } else {
                              textController4.text = '';
                              textController5.text = '';
                              outputHR = '';
                              outputV = '';
                              outputMU = '';
                              outputH = '';
                              outputVP = '';
                              outputSVP = '';
                            }
                          },
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: greenLabel == 3
                                  ? Colors.green
                                  : const Color.fromARGB(0, 244, 67, 54),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 28.0,
          ),

          // Results

          SizedBox(
            height: 26.0,
            child: Text(
              'Results',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          // HR

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20)),
                          color: AppTheme.colors.results,
                        ),
                        child: Tooltip(
                          verticalOffset: 11,
                          message:
                            'Humidity ratio, g of moisture per kg of dry air',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Text(
                            'HR',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: SelectableText(
                          outputHR,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20)),
                          color: AppTheme.colors.results,
                        ),
                        child: Text(
                          outputHRsiip,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 6.0,
          ),

          // v

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Tooltip(
                          verticalOffset: 11,
                          message: 'Specific volume',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Text(
                            'v',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: SelectableText(
                          outputV,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Text(
                          outputVsiip,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 6.0,
          ),

          // MU

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Tooltip(
                          verticalOffset: 11,
                          message: 'Degree of saturation',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Text(
                            'MU',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: SelectableText(
                          outputMU,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Text(
                          outputMUsiip,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 6.0,
          ),

          // h

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Tooltip(
                          verticalOffset: 11,
                          message: 'Enthalpy',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Text(
                            'h',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: SelectableText(
                          outputH,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Text(
                          outputHsiip,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 6.0,
          ),

          // VP

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Tooltip(
                          verticalOffset: 11,
                          message: 'Vapour pressure',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Text(
                            'VP',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: SelectableText(
                          outputVP,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: Text(
                          outputVPsiip,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 6.0,
          ),

          // SVP

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20)),
                          color: AppTheme.colors.results,
                        ),
                        child: Tooltip(
                          verticalOffset: 11,
                          message: 'Saturation vapour pressure',
                          triggerMode: TooltipTriggerMode.tap,
                          child: Text(
                            'SVP',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.results,
                        ),
                        child: SelectableText(
                          outputSVP,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20)),
                          color: AppTheme.colors.results,
                        ),
                        child: Text(
                          outputSVPsiip,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
