import 'package:hvac_calc/psychrometric.dart';
import 'package:hvac_calc/screens/psychrometric_calculator.dart';

class Replacing {
  // from comma to dot
  String commaToDot (value) {
    String f = value.replaceAll(',','.');
    return f;
  }
}

textControllerChanged1 (value) {
  // checking double type and replacing commas
  try {
    value = Replacing().commaToDot(value);
    resultDouble = double.parse(value);
    checkingDouble = true;
  } catch (e) {
    checkingDouble = false;
  }
  // cheking empty
  if (value.isNotEmpty) {
    if (!checkingDouble) {
    errorSwitch = true;
    errorText = 'Incorrect values';
    } else
    // SI - IP checking
    if (initialIndex == 0) {
      textController1.text = value;
      textController2.text = heightFromPressure(double.parse(value)).toStringAsFixed(0);
      if (greenLabel == 1 && textController4.text.isNotEmpty) {
        textControllerChanged4(textController4.text);
      } else
      if (greenLabel == 2 && textController5.text.isNotEmpty) {
        textControllerChanged5(textController5.text);
      } else
      if (greenLabel == 3 && textController6.text.isNotEmpty) {
          textControllerChanged6(textController6.text);
      }
    } else if (initialIndex == 1) {
      textController1.text = value;
      textController2.text = (heightFromPressure(double.parse(value) * 1000 / 0.2953) * 3.28).toStringAsFixed(0);
      if (greenLabel == 1 && textController4.text.isNotEmpty) {
        textControllerChanged4(textController4.text);
      } else
      if (greenLabel == 2  && textController5.text.isNotEmpty) {
        textControllerChanged5(textController5.text);
      } else
      if (greenLabel == 3 && textController6.text.isNotEmpty) {
          textControllerChanged6(textController6.text);
      }    
    }
  } else {
    textController2.text = '';
    outputHR = '';
    outputV = '';
    outputMU = '';
    outputH = '';
    outputVP = '';
    outputSVP = '';
    errorSwitch = false;
  }
}

textControllerChanged2 (value) {
  // checking double type and replacing commas
  try {
    value = Replacing().commaToDot(value);
    resultDouble = double.parse(value);
    checkingDouble = true;
  } catch (e) {
    checkingDouble = false;
  }
  // cheking empty
  if (value.isNotEmpty) {
    if (!checkingDouble) {
    errorSwitch = true;
    errorText = 'Incorrect values';
    } else
    // SI - IP checking
    if (initialIndex == 0) {
      textController2.text = value;
      textController1.text = pressureFromHeight(double.parse(value)).toStringAsFixed(0);
      if (greenLabel == 1 && textController4.text.isNotEmpty) {
        textControllerChanged4(textController4.text);
      } else
      if (greenLabel == 2 && textController5.text.isNotEmpty) {
        textControllerChanged5(textController5.text);
      } else
      if (greenLabel == 3 && textController6.text.isNotEmpty) {
          textControllerChanged6(textController6.text);
      }
    } else if (initialIndex == 1) {
      textController2.text = value;
      textController1.text = (pressureFromHeight(double.parse(value) / 3.28) / 1000 * 0.2953).toStringAsFixed(4);
      if (greenLabel == 1 && textController4.text.isNotEmpty) {
        textControllerChanged4(textController4.text);
      } else
      if (greenLabel == 2 && textController5.text.isNotEmpty) {
        textControllerChanged5(textController5.text);
      } else
      if (greenLabel == 3 && textController4.text.isNotEmpty) {
          textControllerChanged6(textController6.text);
      }
    }
  } else {
    textController1.text = '';
    outputHR = '';
    outputV = '';
    outputMU = '';
    outputH = '';
    outputVP = '';
    outputSVP = '';
    errorSwitch = false;
  }
}

textControllerChanged3 (value) {
// checking double type and replacing commas
  try {
    value = Replacing().commaToDot(value);
    resultDouble = double.parse(value);
    checkingDouble = true;
  } catch (e) {
    checkingDouble = false;
  }
  // cheking empty
  if (value.isNotEmpty) {
    if (!checkingDouble) {
    errorSwitch = true;
    errorText = 'Incorrect values';
    } else
    // SI - IP checking
    if (initialIndex == 0) {
      textController3.text = value;
      if (greenLabel == 1 && textController4.text.isNotEmpty) {
        textControllerChanged4(textController4.text);
      } else
      if (greenLabel == 2 && textController5.text.isNotEmpty) {
        textControllerChanged5(textController5.text);
      } else
      if (greenLabel == 3 && textController6.text.isNotEmpty) {
        textControllerChanged6(textController6.text);
      }
    } else if (initialIndex == 1) {
      textController3.text = value;
      if (greenLabel == 1 && textController4.text.isNotEmpty) {
        textControllerChanged4(textController4.text);
      } else
      if (greenLabel == 2 && textController5.text.isNotEmpty) {
        textControllerChanged5(textController5.text);
      } else
      if (greenLabel == 3 && textController6.text.isNotEmpty) {
        textControllerChanged6(textController6.text);
      }
    }
  } else {
    outputHR = '';
    outputV = '';
    outputMU = '';
    outputH = '';
    outputVP = '';
    outputSVP = '';
    errorSwitch = false;
  }
}

textControllerChanged4 (value) {
  // checking double type and replacing commas
  try {
    value = Replacing().commaToDot(value);
    resultDouble = double.parse(value);
    checkingDouble = true;
  } catch (e) {
    checkingDouble = false;
  }
  // cheking empty
  if (value.isNotEmpty  && textController3.text.isNotEmpty && textController1.text.isNotEmpty) {
    if (!checkingDouble) {
    errorSwitch = true;
    errorText = 'Incorrect values';
    } else
    // SI - IP checking
    if (initialIndex == 0) {
      textController4.text = value;
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
      textController4.text = value;
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
    errorSwitch = false;
  }
}

textControllerChanged5 (value) {
  // checking double type and replacing commas
  try {
    value = Replacing().commaToDot(value);
    resultDouble = double.parse(value);
    checkingDouble = true;
  } catch (e) {
    checkingDouble = false;
  }
  // cheking empty
  if (value.isNotEmpty && textController3.text.isNotEmpty && textController1.text.isNotEmpty) {
    if (!checkingDouble) {
    errorSwitch = true;
    errorText = 'Incorrect values';
    } else
    // SI - IP checking
    if (initialIndex == 0) {
      textController5.text = value;
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
      textController5.text = value;
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
    errorSwitch = false;
  }
}

textControllerChanged6 (value) {
  // checking double type and replacing commas
  try {
    value = Replacing().commaToDot(value);
    resultDouble = double.parse(value);
    checkingDouble = true;
  } catch (e) {
    checkingDouble = false;
  }
  // cheking empty
  if (value.isNotEmpty && textController3.text.isNotEmpty && textController1.text.isNotEmpty) {
    if (!checkingDouble) {
    errorSwitch = true;
    errorText = 'Incorrect values';
    } else
      // SI - IP checking
    if (initialIndex == 0) {
      textController6.text = value;
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
      textController6.text = value;
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
    errorSwitch = false;
  }
}

