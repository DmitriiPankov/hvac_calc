import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hvac_calc/cheking.dart';
import 'package:hvac_calc/main.dart';
import 'package:hvac_calc/psychrometric.dart';
import 'package:toggle_switch/toggle_switch.dart';

int? initialIndex = 0;

var greenLabel = 0;
var label1 = 0;
var label2 = 1;

double resultDouble = 0;
bool checkingDouble = true;
String lastValue = '';

var textController1 = TextEditingController(text: '101325'); // p
var textController2 = TextEditingController(text: '0'); // h
var textController3 = TextEditingController(text: '20.0'); // tdb
var textController4 = TextEditingController(text: ''); // fi
var textController5 = TextEditingController(text: ''); // twb
var textController6 = TextEditingController(text: ''); // tdp

class PsychrometricCalculator extends StatefulWidget {
  const PsychrometricCalculator({super.key});

  @override
  State<PsychrometricCalculator> createState() => _PsychrometricCalculator();
  }

class _PsychrometricCalculator extends State<PsychrometricCalculator> {
  final colorsTheme = Colors.black;

  String namePressure = 'Pressure, Pa';
  String nameAltitude = 'Altitude, m';
  String nameTdb = 'Tdb, °C';
  String nameF = 'f, %';
  String nameTwb = 'Twb, °C';
  String nameTdp = 'Tdp, °C';

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: '101325'); // p
    textController2 = TextEditingController(text: '0'); // h
    textController3 = TextEditingController(text: '20.0'); // tdb
    textController4 = TextEditingController(text: ''); // fi
    textController5 = TextEditingController(text: ''); // twb
    textController6 = TextEditingController(text: ''); // tdp
    initialIndex = 0;

    greenLabel = 0;
    label1 = 0;
    label2 = 1;
    resultDouble = 0;
    checkingDouble = true;
    lastValue = '';
    
  }

  @override
  void dispose() {
    initialIndex = 0;
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    textController5.dispose();
    textController6.dispose();
    outputHR = '';
    outputV = '';
    outputMU = '';
    outputH = '';
    outputVP = '';
    outputSVP = '';
    outputHRsiip = '';
    outputHRsiip = '';
    outputVsiip = '';
    outputMUsiip = '';
    outputHsiip = '';
    outputVPsiip = '';
    outputSVPsiip = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color.fromARGB(255, 255, 255, 255), 
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
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
          'Psychrometric calculator',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            color: AppTheme.colors.font1,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 5.0,
            ),
      
            // SI - IP toggle switch
      
            ToggleSwitch(
              labels: const ['SI', 'IP'],
              // inactiveFgColor: const Color.fromARGB(255, 255, 0, 0),
              
              curve: Curves.easeIn,
              animate: true,
              animationDuration: 400,
              initialLabelIndex: initialIndex,
              totalSwitches: 2,
              minHeight: 28,
              minWidth: 70,
              cornerRadius: 14,
              activeBgColor: [
                AppTheme.colors.toggle,
                Color.fromARGB(150, 64, 179, 255),
              ],
              
              inactiveBgColor: AppTheme.colors.field,
              radiusStyle: true,
              onToggle: (index) {
                
                  if (index == 1 && label1 == 0) {
                    namePressure = 'Pressure, in Hg';
                    nameAltitude = 'Altitude, ft';
                    nameTdb = 'Tdb, °F';
                    nameF = 'f, %';
                    nameTwb = 'Twb, °F';
                    nameTdp = 'Tdp, °F';
                    label1 = 1;
                    label2 = 0;
                    initialIndex = 1;

                    // from SI to IP
                    
                    if (textController1.text.isNotEmpty) {
                    textController1.text =
                        (double.parse(textController1.text) / 1000 * 0.2953)
                            .toStringAsFixed(4);}
                    if (textController2.text.isNotEmpty) {
                    textController2.text =
                        (double.parse(textController2.text) * 3.28)
                            .toStringAsFixed(0);}
                    if (textController3.text.isNotEmpty) {
                    textController3.text =
                        ((double.parse(textController3.text) * 9 / 5) + 32)
                            .toStringAsFixed(1);}
                    if (textController5.text.isNotEmpty) {
                    textController5.text =
                        (((double.parse(textController5.text)) * 9 / 5) + 32)
                            .toStringAsFixed(1);}
                    if (textController6.text.isNotEmpty) {
                    textController6.text =
                        (((double.parse(textController6.text)) * 9 / 5) + 32)
                            .toStringAsFixed(1);}
                    if (greenLabel == 1) {
                      textControllerChanged4(textController4.text);
                    } else
                    if (greenLabel == 2) {
                      textControllerChanged5(textController5.text);
                    } else
                    if (greenLabel == 3) {
                      textControllerChanged6(textController6.text);
                    }
                    setState(() {initialIndex = 1;});
      
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
                    initialIndex = 0;
                    
      
                    if (textController1.text.isNotEmpty) {
                    textController1.text =
                        (double.parse(textController1.text) * 1000 / 0.2953)
                            .toStringAsFixed(0);}
                    if (textController2.text.isNotEmpty) {
                    textController2.text =
                        (double.parse(textController2.text) / 3.28)
                            .toStringAsFixed(0);}
                    if (textController3.text.isNotEmpty) {
                    textController3.text =
                        ((double.parse(textController3.text) - 32) * 5 / 9)
                            .toStringAsFixed(1);}
                    if (textController5.text.isNotEmpty) {
                    textController5.text =
                        ((double.parse(textController5.text) - 32) * 5 / 9)
                            .toStringAsFixed(1);}
                    if (textController6.text.isNotEmpty) {
                    textController6.text =
                        ((double.parse(textController6.text) - 32) * 5 / 9)
                            .toStringAsFixed(1);}
                    if (greenLabel == 1) {
                      textControllerChanged4(textController4.text);
                    } else
                    if (greenLabel == 2) {
                      textControllerChanged5(textController5.text);
                    } else
                    if (greenLabel == 3) {
                      textControllerChanged6(textController6.text);
                    }
                    setState(() {initialIndex = 0;});
                  }
                  
                
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
                  
                  // Pressure
                  
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          namePressure,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          controller: textController1,
                          onChanged: (value) {
                            setState(() {});
                            textControllerChanged1(value);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: AppTheme.colors.field,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0), 
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(
                    width: 12.0,
                  ),
                  
                  //Altitude
                  
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          nameAltitude,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          controller: textController2,
                          onChanged: (value) {
                            setState(() {});
                            textControllerChanged2(value);
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: AppTheme.colors.field,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0), 
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
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
                  SizedBox(
                    width: 160,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.headlineMedium,
                      controller: textController3,
                      onChanged: (value) {
                              setState(() {});
                              textControllerChanged3(value);
                            },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                              isDense: true,
                              fillColor: AppTheme.colors.field,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                                borderRadius: BorderRadius.circular(14.0), 
                              ),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                                borderRadius: BorderRadius.circular(14.0),),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
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
                        TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          controller: textController4,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 1;
                              textControllerChanged4(value);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIconConstraints: const BoxConstraints(maxHeight: 26, maxWidth: 26),
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.check,
                                size: 20,
                                color: greenLabel == 1
                                    ? Colors.green
                                    : const Color.fromARGB(0, 244, 67, 54),
                              ),
                            ),
                            isDense: true,
                            fillColor: AppTheme.colors.field,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0), 
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  const SizedBox(
                    width: 12.0,
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
                        TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          controller: textController5,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 2;
                              textControllerChanged5(value);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIconConstraints: const BoxConstraints(maxHeight: 26, maxWidth: 26),
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.check,
                                color: greenLabel == 2
                                    ? Colors.green
                                    : const Color.fromARGB(0, 244, 67, 54),
                              ),
                            ),
                            isDense: true,
                            fillColor: AppTheme.colors.field,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0), 
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(
                    width: 12.0,
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
                        TextFormField(
                          style: Theme.of(context).textTheme.headlineMedium,
                          controller: textController6,
                          onChanged: (value) {
                            setState(() {
                              greenLabel = 3;
                              textControllerChanged6(value);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixIconConstraints: const BoxConstraints(maxHeight: 26, maxWidth: 26),
                            suffixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 12.0),
                              child: Icon(
                                Icons.check,
                                color: greenLabel == 3
                                    ? Colors.green
                                    : const Color.fromARGB(0, 244, 67, 54),
                              ),
                            ),
                            isDense: true,
                            fillColor: AppTheme.colors.field,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0), 
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.colors.field, width: 5),
                              borderRadius: BorderRadius.circular(14.0),),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
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
      
            Builder(
              builder: (context) {
                if (errorSwitch) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppTheme.colors.results,
                    ),
                    child: Text(
                      errorText,
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                } else { return 
      
                  Column(
                    children: [
      
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
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(14)),
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
                                    height: 42,
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
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(14)),
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                                    height: 42,
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
                        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                children: [
                                  Container(
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(14)),
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
                                    height: 42,
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
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(14)),
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
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
