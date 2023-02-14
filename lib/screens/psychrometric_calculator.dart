import 'package:flutter/material.dart';
import 'package:hvac_calc/main.dart';
import 'package:hvac_calc/psychrometric.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PsychrometricCalculator extends StatefulWidget {
  const PsychrometricCalculator({super.key});

  @override
  State<PsychrometricCalculator> createState() => _PsychrometricCalculator();
}

class _PsychrometricCalculator extends State<PsychrometricCalculator> {
  final colorsTheme = Colors.black;

  final textController1 = TextEditingController(text: '101325'); // p
  final textController2 = TextEditingController(text: '0'); // h
  final textController3 = TextEditingController(text: '20'); // tdb
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

  int? initialIndex = 0;

  @override
  void dispose() {
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
                if (index == 1) {
                  namePressure = 'Pressure, in Hg';
                  nameAltitude = 'Altitude, ft';
                  nameTdb = 'Tdb, °F';
                  nameF = 'f, %';
                  nameTwb = 'Twb, °F';
                  nameTdp = 'Tdp, °F';
                } else if (index == 0) {
                  namePressure = 'Pressure, Pa';
                  nameAltitude = 'Altitude, m';
                  nameTdb = 'Tdb, °C';
                  nameF = 'f, %';
                  nameTwb = 'Twb, °C';
                  nameTdp = 'Tdp, °C';
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
                        child: TextFormField(
                          controller: textController1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              textController2.text =
                                  heightFromPressure(int.parse(value))
                                      .toStringAsFixed(2);
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
                        child: TextFormField(
                          controller: textController2,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              textController1.text =
                                  pressureFromHeight(int.parse(value))
                                      .toStringAsFixed(0);
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
                        child: TextFormField(
                          controller: textController4,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 1;
                            });
                            if (value.isNotEmpty) {
                              textController5.text = getTWetBulbFromRelHum(
                                fi: num.parse(value) / 100,
                                tdb: num.parse(textController3.text),
                                p: num.parse(textController1.text),
                              ).toStringAsFixed(1);
                              textController6.text = getTDewPointFromRelHum(
                                fi: num.parse(value) / 100,
                                tdb: num.parse(textController3.text),
                              ).toStringAsFixed(1);
                              calcPsychrometricsFromRelHum(
                                tdb: int.parse(textController3.text),
                                fi: int.parse(value),
                                p: num.parse(textController1.text),
                              );
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
                        child: TextFormField(
                          controller: textController5,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 2;
                            });
                            if (value.isNotEmpty) {
                              textController6.text = getTDewPointFromTWetBulb(
                                twb: num.parse(value),
                                tdb: num.parse(textController3.text),
                                p: num.parse(textController1.text),
                              ).toStringAsFixed(1);
                              textController4.text = (getRelHumFromTWetBulb(
                                        twb: num.parse(value),
                                        tdb: num.parse(textController3.text),
                                        p: num.parse(textController1.text),
                                      ) *
                                      100)
                                  .toStringAsFixed(1);
                              calcPsychrometricsFromTWetBulb(
                                tdb: int.parse(textController3.text),
                                twb: int.parse(value),
                                p: num.parse(textController1.text),
                              );
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
                        child: TextFormField(
                          controller: textController6,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 3;
                            });
                            if (value.isNotEmpty) {
                              textController5.text = getTWetBulbFromTDewPoint(
                                tdp: num.parse(value),
                                tdb: num.parse(textController3.text),
                                p: num.parse(textController1.text),
                              ).toStringAsFixed(1);
                              textController4.text = (getRelHumFromTDewPoint(
                                        tdp: num.parse(value),
                                        tdb: num.parse(textController3.text),
                                      ) *
                                      100)
                                  .toStringAsFixed(1);
                              calcPsychrometricsFromTDewPoint(
                                tdb: int.parse(textController3.text),
                                tdp: int.parse(value),
                                p: num.parse(textController1.text),
                              );
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
