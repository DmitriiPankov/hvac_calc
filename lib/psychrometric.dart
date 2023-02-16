//*****************************************************************************
//       Conversions between dew point, wet bulb, and relative humidity
//*****************************************************************************

import 'dart:math';
import 'package:hvac_calc/screens/psychrometric_calculator.dart';

double tC = 20;
double p = 101325;
double tdb = 20;
double pv = 0;
double fi = 0;
double w = 0;
double pws = 0;
String popUp = '';
double tdp = 20;
double h = 0;

double lnPws = 0;

String outputHR = '';
String outputV = '';
String outputMU = '';
String outputH = '';
String outputVP = '';
String outputSVP = '';

String outputHRsiip = '';
String outputVsiip = '';
String outputMUsiip = '';
String outputHsiip = '';
String outputVPsiip = '';
String outputSVPsiip = '';

pressureFromHeight(h) {
  var p = 101325 * pow(e, -h / 8435.2);
  return p;
}

heightFromPressure(p) {
  var h = (-8435.2 * log(p / 101325));
  return h;
}

///////////////////////////////////////////////////////////////////////////////
// Wet-bulb temperature given dry-bulb temperature and dew-point temperature
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getTWetBulbFromTDewPoint({required num tdp, required num tdb, required num p}) {
  //tdb, tdp, p
  var w = getHumRatioFromTDewPoint(tC: tdp, p: p);
  return getTWetBulbFromHumRatio(w: w, tdb: tdb, p: p);
}

///////////////////////////////////////////////////////////////////////////////
// Wet-bulb temperature given dry-bulb temperature and relative humidity
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getTWetBulbFromRelHum({required num tdb, required num fi, required num p}) {
  // tdb, fi, p
  var w = getHumRatioFromRelHum(tdb: tdb, fi: fi, p: p);
  return getTWetBulbFromHumRatio(tdb: tdb, p: p, w: w);
}

///////////////////////////////////////////////////////////////////////////////
// Relative Humidity given dry-bulb temperature and dew-point temperature
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getRelHumFromTDewPoint({required num tdp, required num tdb}) {
  // tdb, tdp
  var pv = getSatVapPres(tC: tdp); // Eqn. 36
  var psv = getSatVapPres(tC: tdb);
  return pv / psv; // Eqn. 24
}

///////////////////////////////////////////////////////////////////////////////
// Relative Humidity given dry-bulb temperature and wet bulb temperature
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getRelHumFromTWetBulb({required num tdb, required num twb, required num p}) {
  //tdb,twb,p
  var w = getHumRatioFromTWetBulb(tdb: tdb, twb: twb, p: p);
  return getRelHumFromHumRatio(tC: tdb, w: w, p: p);
}

///////////////////////////////////////////////////////////////////////////////
// Dew Point Temperature given dry bulb temperature and relative humidity
// ASHRAE Fundamentals (2005) ch. 6 eqn 24
// ASHRAE Fundamentals (2009) ch. 1 eqn 24
//
getTDewPointFromRelHum({required num tdb, required num fi}) {
  // tdb, fi
  var pv = getVapPresFromRelHum(tdb: tdb, fi: fi);
  return getTDewPointFromVapPres(tC: tdb, pv: pv);
}

///////////////////////////////////////////////////////////////////////////////
// Dew Point Temperature given dry bulb temperature and wet bulb temperature
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getTDewPointFromTWetBulb({required num tdb, required num twb, required num p}) {
  // tdb, twb, p
  var w = getHumRatioFromTWetBulb(tdb: tdb, twb: twb, p: p);
  return getTDewPointFromHumRatio(tdb: tdb, w: w, p: p);
}

//*****************************************************************************
//  Conversions between dew point, or relative humidity and vapor pressure
//*****************************************************************************

///////////////////////////////////////////////////////////////////////////////
// Partial pressure of water vapor as a function of relative humidity and
// temperature in C
// ASHRAE Fundamentals (2005) ch. 6, eqn. 24
// ASHRAE Fundamentals (2009) ch. 1, eqn. 24
//

getVapPresFromRelHum({required num tdb, required num fi}) {
  //tdb,fi
  return fi * getSatVapPres(tC: tdb);
}

///////////////////////////////////////////////////////////////////////////////
// Relative Humidity given dry bulb temperature and vapor pressure
// ASHRAE Fundamentals (2005) ch. 6, eqn. 24
// ASHRAE Fundamentals (2009) ch. 1, eqn. 24
//
getRelHumFromVapPres({required num pv, required num tdb}) {
  //pv,tdb
  return pv / getSatVapPres(tC: tdb);
}

///////////////////////////////////////////////////////////////////////////////
// Dew point temperature given vapor pressure and dry bulb temperature
// ASHRAE Fundamentals (2005) ch. 6, eqn. 39 and 40
// ASHRAE Fundamentals (2009) ch. 1, eqn. 39 and 40
//
getTDewPointFromVapPres({required num tC, required num pv}) {
  //tC, pv
  double alpha = 0;
  double td = 0;
  pv = pv / 1000;
  alpha = log(pv);
  if (tC >= 0 && tC <= 93) {
    td = 6.54 +
        14.526 * alpha +
        0.7389 * alpha * alpha +
        0.09486 * pow(alpha, 3) +
        0.4569 * pow(pv, 0.1984);
  } // (39)
  else if (tC < 0) {
    td = 6.09 + 12.608 * alpha + 0.4959 * alpha * alpha;
  } // (40)
  else {
    td = -1000;
  } // Invalid value
  return td;
}

//*****************************************************************************
//        Conversions from wet bulb temperature, dew point temperature,
//                or relative humidity to humidity ratio
//*****************************************************************************

///////////////////////////////////////////////////////////////////////////////
// Wet bulb temperature given humidity ratio
// ASHRAE Fundamentals (2005) ch. 6 eqn. 35
// ASHRAE Fundamentals (2009) ch. 1 eqn. 35
//

getTWetBulbFromHumRatio({required num tdb, required num p, required num w}) {
  //tdb, p, w
  var tdp = getTDewPointFromHumRatio(tdb: tdb, p: p, w: w);
  var tWetBulbSup = tdb;
  var tWetBulbInf = tdp;
  var twb = (tWetBulbInf * 1 + tWetBulbSup * 1) / 2;

  while ((tWetBulbSup - tWetBulbInf) > 0.001) {
    var wstar = getHumRatioFromTWetBulb(tdb: tdb, twb: twb, p: p);
    if (wstar * 1 > w * 1) {
      tWetBulbSup = twb;
    } else {
      tWetBulbInf = twb;
    }
    twb = (tWetBulbSup * 1 + tWetBulbInf * 1) / 2;
  }
  return twb;
}

///////////////////////////////////////////////////////////////////////////////
// Humidity ratio given wet bulb temperature and dry bulb temperature
// ASHRAE Fundamentals (2005) ch. 6 eqn. 35
// ASHRAE Fundamentals (2009) ch. 1 eqn. 35
//

getHumRatioFromTWetBulb({required num tdb, required num twb, required num p}) {
  //tdb,twb,p
  var wsstar = getSatHumRatio(tC: twb, p: p);
  return (((2501 - 2.326 * twb) * wsstar - 1.006 * (tdb - twb)) /
      (2501 + 1.86 * tdb - 4.186 * twb));
}

///////////////////////////////////////////////////////////////////////////////
// Humidity ratio given relative humidity
// ASHRAE Fundamentals (2005) ch. 6 eqn. 38
// ASHRAE Fundamentals (2009) ch. 1 eqn. 38
//
getHumRatioFromRelHum({required num tdb, required num fi, required num p}) {
  //tdb,fi,p
  var vapPres = getVapPresFromRelHum(tdb: tdb, fi: fi);
  return getHumRatioFromVapPres(pv: vapPres, p: p);
}

///////////////////////////////////////////////////////////////////////////////
// Relative humidity given humidity ratio
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getRelHumFromHumRatio({required num tC, required num w, required num p}) {
  //tC, p,w
  var pv = getVapPresFromHumRatio(w: w, p: p);
  return getRelHumFromVapPres(pv: pv, tdb: tC);
}

///////////////////////////////////////////////////////////////////////////////
// Humidity ratio given dew point temperature and pressure.
// ASHRAE Fundamentals (2005) ch. 6 eqn. 22
// ASHRAE Fundamentals (2009) ch. 1 eqn. 22
//
getHumRatioFromTDewPoint({required num tC, required num p}) {
  var vapPres = getSatVapPres(tC: tC);
  return getHumRatioFromVapPres(pv: vapPres, p: p);
}

///////////////////////////////////////////////////////////////////////////////
// Dew point temperature given dry bulb temperature, humidity ratio, and pressure
// ASHRAE Fundamentals (2005) ch. 6
// ASHRAE Fundamentals (2009) ch. 1
//
getTDewPointFromHumRatio({required num tdb, required num p, required num w}) {
  //tdb,p,w
  var vapPres = getVapPresFromHumRatio(w: w, p: p);
  return getTDewPointFromVapPres(tC: tdb, pv: vapPres);
}

//*****************************************************************************
//       Conversions between humidity ratio and vapor pressure
//*****************************************************************************

///////////////////////////////////////////////////////////////////////////////
// Humidity ratio given water vapor pressure and atmospheric pressure
// ASHRAE Fundamentals (2005) ch. 6 eqn. 22
// ASHRAE Fundamentals (2009) ch. 1 eqn. 22
//

getHumRatioFromVapPres({required num pv, required num p}) {
  return 0.621945 * pv / (p - pv);
}

///////////////////////////////////////////////////////////////////////////////
// Vapor pressure given humidity ratio and pressure
// ASHRAE Fundamentals (2005) ch. 6 eqn. 22
// ASHRAE Fundamentals (2009) ch. 1 eqn. 22
//

getVapPresFromHumRatio({required num p, required num w}) {
  return p * w / (0.621945 + w);
}

//*****************************************************************************
//                             Dry Air Calculations
//*****************************************************************************

///////////////////////////////////////////////////////////////////////////////
// Dry air enthalpy given dry bulb temperature.
// ASHRAE Fundamentals (2005) ch. 6 eqn. 30
// ASHRAE Fundamentals (2009) ch. 1 eqn. 30
//
getDryAirEnthalpy(tC) {
  return 1.006 * tC * 1000;
}

///////////////////////////////////////////////////////////////////////////////
// Dry air density given dry bulb temperature and pressure.
// ASHRAE Fundamentals (2005) ch. 6 eqn. 28
// ASHRAE Fundamentals (2009) ch. 1 eqn. 28
//

getDryAirDensity(args) {
  return (args.p / 1000) * 0.028966 / (8.314472 * ctok(args.tC));
}

///////////////////////////////////////////////////////////////////////////////
// Dry air volume given dry bulb temperature and pressure.
// ASHRAE Fundamentals (2005) ch. 6 eqn. 28
// ASHRAE Fundamentals (2009) ch. 1 eqn. 28
//

getDryAirVolume(args) {
  return 8.314472 * ctok(args.tC) / ((args.p / 1000) * 0.028966);
}

//*****************************************************************************
//                       Saturated Air Calculations
//*****************************************************************************

///////////////////////////////////////////////////////////////////////////////
// Saturation vapor pressure as a function of temperature
// ASHRAE Fundamentals (2005) ch. 6 eqn. 5, 6
// ASHRAE Fundamentals (2009) ch. 1 eqn. 5, 6
// pws = saturation pressure, Pa

ctok(tC) {
  return (tC * 1 + 273.15);
}

getSatVapPres({required num tC}) {
  var tK = ctok(tC);

  if (tC >= -100 && tC <= 0) {
    lnPws = (-5.6745359E+03 / tK +
        6.3925247 -
        9.677843E-03 * tK +
        6.2215701E-07 * tK * tK +
        2.0747825E-09 * pow(tK, 3) -
        9.484024E-13 * pow(tK, 4) +
        4.1635019 * log(tK));
  } else if (tC <= 200 && tC >= 0) {
    lnPws = (-5.8002206E+03 / tK +
        1.3914993 -
        4.8640239E-02 * tK +
        4.1764768E-05 * tK * tK -
        1.4452093E-08 * pow(tK, 3) +
        6.5459673 * log(tK));
  }
  return pow(e, lnPws);
}

///////////////////////////////////////////////////////////////////////////////
// Humidity ratio of saturated air given dry bulb temperature and pressure.
// ASHRAE Fundamentals (2005) ch. 6 eqn. 23
// ASHRAE Fundamentals (2009) ch. 1 eqn. 23
//
getSatHumRatio({required num tC, required num p}) {
  //tC,p
  return (0.621945 * getSatVapPres(tC: tC) / (p - getSatVapPres(tC: tC)));
}

///////////////////////////////////////////////////////////////////////////////
// Saturated air enthalpy given dry bulb temperature and pressure
// ASHRAE Fundamentals (2005) ch. 6 eqn. 32
//

getSatAirEnthalpy({required num tC}) {
  return getMoistAirEnthalpy(tC: tC, w: getSatHumRatio(tC: tC, p: p));
}

//*****************************************************************************
//                       Moist Air Calculations
//*****************************************************************************

///////////////////////////////////////////////////////////////////////////////
// Vapor pressure deficit in Pa given humidity ratio, dry bulb temperature, and
// pressure.
// See Oke (1987) eqn. 2.13a
//

getVPD({required num tC, required num p, required num w}) {
  return getSatVapPres(tC: tC) *
      (1 - getRelHumFromHumRatio(tC: tC, p: p, w: w));
}

///////////////////////////////////////////////////////////////////////////////
// ASHRAE Fundamentals (2005) ch. 6 eqn. 12
// ASHRAE Fundamentals (2009) ch. 1 eqn. 12
//

getDegreeOfSaturation({required num w, required num tC, required num p}) {
  return w / getSatHumRatio(tC: tC, p: p);
}

///////////////////////////////////////////////////////////////////////////////
// Moist air enthalpy given dry bulb temperature and humidity ratio
// ASHRAE Fundamentals (2005) ch. 6 eqn. 32
// ASHRAE Fundamentals (2009) ch. 1 eqn. 32
//
getMoistAirEnthalpy({required num tC, required num w}) {
  return (1.006 * tC + w * (2501.0 + 1.86 * tC)) * 1000;
}

///////////////////////////////////////////////////////////////////////////////
// Moist air volume given dry bulb temperature, humidity ratio, and pressure.
// ASHRAE Fundamentals (2005) ch. 6 eqn. 28
// ASHRAE Fundamentals (2009) ch. 1 eqn. 28
//
getMoistAirVolume({required num tC, required num w, required num p}) {
  return 0.287042 * (ctok(tC)) * (1.0 + 1.607858 * w) / (p / 1000);
}

///////////////////////////////////////////////////////////////////////////////
// Moist air density given humidity ratio, dry bulb temperature, and pressure
// ASHRAE Fundamentals (2005) ch. 6 6.8 eqn. 11
// ASHRAE Fundamentals (2009) ch. 1 1.8 eqn 11
//

getMoistAirDensity({required num tC, required num w, required num p}) {
  return (1 + w) / getMoistAirVolume(tC: tC, w: w, p: p);
}

//*****************************************************************************
//                Functions to set all psychrometric values
//*****************************************************************************

calcPsychrometricsFromTWetBulb(
    {required num tdb, required num twb, required num p}) {
  //tdb, twb, p
  var w = getHumRatioFromTWetBulb(tdb: tdb, twb: twb, p: p);
  var tdp = getTDewPointFromHumRatio(w: w, tdb: tdb, p: p);
  var fi = getRelHumFromHumRatio(tC: tdb, w: w, p: p);

  if (tdb.isNaN || twb.isNaN || p.isNaN) {
    return {popUp: "Incorrect value", fi: '', tdp: ''};
  }
  if (tdb > 93 || tdb < -100) {
    return {
      popUp:
          "Dry bulb temperature is outside range [-100...+93] °C or [-148...+199] °F",
      fi: '',
      tdp: ''
    };
  }
  if (tdb * 1 < twb * 1) {
    return {
      popUp: "<Wet bulb temperature is above dry bulb temperature",
      fi: '',
      tdp: ''
    };
  }
  if (twb < -100) {
    return {
      popUp:
          "Wet bulb temperature is outside range [-100...+93] °C or [-148...+199] °F",
      fi: '',
      tdb: ''
    };
  }

  var pv = getVapPresFromHumRatio(w: w, p: p);
  var ima = getMoistAirEnthalpy(tC: tdb, w: w);
  var vma = getMoistAirVolume(tC: tdb, w: w, p: p);
  var degSaturation = getDegreeOfSaturation(tC: tdb, w: w, p: p);
  var satVapPres = getSatVapPres(tC: tdb);

  if (w * 1 <= 0 || pv * 1 <= 0) {
    return {popUp: "Incorrect values", fi: '', tdp: ''};
  }
  return {
    popUp: psiCalcGetOutput(w, vma, degSaturation, ima, pv, satVapPres),
    fi: (fi * 100).toStringAsFixed(1),
    tdp: tdp
  };
}

calcPsychrometricsFromTDewPoint(
    {required num tdb, required num tdp, required num p}) {
  //tdb, tdp, p
  var w = getHumRatioFromTDewPoint(tC: tdp, p: p);
  var twb = getTWetBulbFromHumRatio(tdb: tdb, p: p, w: w);
  var fi = getRelHumFromHumRatio(tC: tdb, w: w, p: p);

  if (tdb.isNaN || tdp.isNaN || p.isNaN) {
    return {popUp: "Incorrect value", fi: '', twb: ''};
  }
  if (tdb > 93 || tdb < -100) {
    return {
      popUp:
          "Dry bulb temperature is outside range [-100...+93] °C or [-148...+199] °F",
      fi: '',
      twb: ''
    };
  }
  if (tdb * 1 < tdp * 1) {
    return {
      popUp: "Dew point temperature is above dry bulb temperature",
      fi: '',
      twb: ''
    };
  }
  if (tdp < -100) {
    return {
      popUp:
          "Dew point temperature is outside range [-100...+93] °C or [-148...+199] °F",
      fi: '',
      twb: ''
    };
  }

  var pv = getVapPresFromHumRatio(w: w, p: p);
  var ima = getMoistAirEnthalpy(tC: tdb, w: w);
  var vma = getMoistAirVolume(tC: tdb, w: w, p: p);
  var degSaturation = getDegreeOfSaturation(tC: tdb, w: w, p: p);
  var satVapPres = getSatVapPres(tC: tdb);

  if (w * 1 <= 0 || pv * 1 <= 0) {
    return {popUp: "Incorrect values", fi: '', tdp: ''};
  }
  return {
    popUp: psiCalcGetOutput(w, vma, degSaturation, ima, pv, satVapPres),
    fi: (fi * 100).toStringAsFixed(1),
    twb: twb
  };
}

calcPsychrometricsFromRelHum(
    {required num tdb, required num fi, required num p}) {
  //tdb, fi, p
  var w = getHumRatioFromRelHum(tdb: tdb, fi: fi / 100, p: p);
  var twb = getTWetBulbFromHumRatio(tdb: tdb, p: p, w: w);
  var tdp = getTDewPointFromHumRatio(w: w, tdb: tdb, p: p);

  if (tdb.isNaN || fi.isNaN || p.isNaN) {
    return {popUp: "Incorrect value", twb: '', tdp: ''};
  }
  if (tdb > 93 || tdb < -100) {
    return {
      popUp:
          "Dry bulb temperature is outside range [-100...+93] °C or [-148...+199] °F",
      twb: '',
      tdp: ''
    };
  }
  if (fi * 1 > 100 || fi * 1 <= 0) {
    return {
      popUp: "Relative humidity is outside range [0...100]",
      twb: '',
      tdp: ''
    };
  }

  var pv = getVapPresFromHumRatio(w: w, p: p);
  var ima = getMoistAirEnthalpy(tC: tdb, w: w);
  var vma = getMoistAirVolume(tC: tdb, w: w, p: p);
  var degSaturation = getDegreeOfSaturation(tC: tdb, w: w, p: p);
  var satVapPres = getSatVapPres(tC: tdb);

  if (w * 1 <= 0 || pv * 1 <= 0) {
    return {popUp: "Incorrect values", twb: '', tdp: ''};
  }
  return {
    popUp: psiCalcGetOutput(w, vma, degSaturation, ima, pv, satVapPres),
    twb: twb,
    tdp: tdp
  };
}

psiCalcGetOutput(w, vma, degSaturation, ima, pv, satVapPres) {
  // if (document.getElementsByName('group1')[0].checked) {
  //  if (querySelectorAll('[name="group1"]')[0].checked) {
  if (initialIndex == 0) {
    // Si calculation
    outputHR = (w * 1000).toStringAsFixed(2);
    outputV = vma.toStringAsFixed(3);
    outputMU = degSaturation.toStringAsFixed(3);
    outputH = (ima / 1000).toStringAsFixed(2);
    outputVP = pv.toStringAsFixed(2);
    outputSVP = satVapPres.toStringAsFixed(2);
    outputHRsiip = 'gH2O/kgAir';
    outputHRsiip = 'gH2O/kgAir';
    outputVsiip = 'm3/kg';
    outputMUsiip = '';
    outputHsiip = 'kJ/kg';
    outputVPsiip = 'Pa';
    outputSVPsiip = 'Pa';

    return {
      outputHR,
      outputV,
      outputMU,
      outputH,
      outputVP,
      outputSVP,
      outputHRsiip,
      outputVsiip,
      outputMUsiip,
      outputHsiip,
      outputVPsiip,
      outputSVPsiip,
    };
  } else {
    // Ip calculaction
    outputHR = (w * 1000 * 15.43 / 2.2).toStringAsFixed(2);
    outputV = (vma * 3.2808 * 3.2808 * 3.2808 / 2.2046).toStringAsFixed(3);
    outputMU = degSaturation.toStringAsFixed(3);
    outputH = (((ima / 1000) * 0.9478 / 2.2046) + 7.68).toStringAsFixed(2);
    outputVP = (pv * 0.0000098692326700).toStringAsFixed(2);
    outputSVP = (satVapPres * 0.0000098692326700).toStringAsFixed(2);
    outputHRsiip = 'grainsH2O/lbAir';
    outputVsiip = 'ft3/lb';
    outputMUsiip = '';
    outputHsiip = 'BTU/lb';
    outputVPsiip = 'Atm';
    outputSVPsiip = 'Atm';
    return {
      outputHR,
      outputV,
      outputMU,
      outputH,
      outputVP,
      outputSVP,
      outputHRsiip,
      outputVsiip,
      outputMUsiip,
      outputHsiip,
      outputVPsiip,
      outputSVPsiip,
    };
  }
}
