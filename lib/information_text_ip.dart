import 'package:flutter/material.dart';
import 'package:hvac_calc/information_text_converting.dart';
import 'package:hvac_calc/screens/about_the_calculation.dart';
import 'main.dart';

Widget informationTextIp () {
  return Column(
    children: [
      myVerticalOffset(10),
      myBlueHeadline('Pressure, psia'),
      myFormula(r'p = 14.696(1-6.8754 \times 10^{-6}Z)^{5.2559}', '3'),
      mySimpleLeftText('where'),
      myFormulaWhere(r'Z\:-\:', 'altitude, ft'),
      myVerticalOffset(10),
      
      // Branch #1 Initial data - dry-bulb temperature and wet-bulb temperature

      ListTileTheme(
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
            'Initial data - dry-bulb temperature and wet-bulb temperature',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          children: [
            myBlueHeadlineSub('Water vapor saturation pressure Pws, psia'),
            mySimpleJustifyText(
              '\t\t\tThe water vapor saturation pressure is required to determine '
              'a number of moist air properties, principally the saturation humidity '
              'ratio. Values may be calculated from '
              'formulas given by IPAWS R7-97(2012) and R14-08 (2011).\n'
              '\t\t\tThe saturation (sublimation) pressure over ice for the temperature '
              'range of -148 to 32°F is given by'
            ),
            myFormula(r'\mathrm{ln\:}p_{ws}=C_1/T+C_2+C_3T+C_4T^2+C_5T^3+C_6T^4+C_7\:{ln\:}T', '5'),
            mySimpleLeftText('where'),
            myFormulaLeft(r'C_1=-1.0214165\:\mathrm{E}\text{+}04'),
            myFormulaLeft(r'C_2=-4.8932428\:\mathrm{E}\text{+}00'),
            myFormulaLeft(r'C_3=-5.3765794\:\mathrm{E}\text{-}03'),
            myFormulaLeft(r'C_4=1.9202377\:\mathrm{E}\text{-}07'),
            myFormulaLeft(r'C_5=3.5575832\:\mathrm{E}\text{-}10'),
            myFormulaLeft(r'C_6=-9.0344688\:\mathrm{E}\text{-}14'),
            myFormulaLeft(r'C_7=4.1635019\:\mathrm{E}\text{+}00'),
            mySimpleJustifyText(
              '\t\t\tThe saturation pressure over liquid water for the '
              'temperature range of 32 to 392°F is given by'
            ),
            myFormula(r'\mathrm{ln\:}p_{ws}=C_8/T+C_9+C_{10}T+C_{11}T^2+C_{12}T^3+C_{13}\:{ln\:}T', '6'),
            mySimpleLeftText('where'),
            myFormulaLeft(r'C_8=-1.0440397\:\mathrm{E}\text{+}04'),
            myFormulaLeft(r'C_9=-1.1294650\:\mathrm{E}\text{+}01'),
            myFormulaLeft(r'C_{10}=-2.7022355\:\mathrm{E}\text{-}02'),
            myFormulaLeft(r'C_{11}=1.2890360\:\mathrm{E}\text{-}05'),
            myFormulaLeft(r'C_{12}=-2.4780681\:\mathrm{E}\text{-}09'),
            myFormulaLeft(r'C_{13}=6.5459673\:\mathrm{E}\text{+}00'),
            myFormulaWhere(r'T\:-\:', 'absolute temperature, °R = °F + 459.67'),
            myBlueHeadlineSub('Saturation humidity ratio Ws, lbw/lbda'),
            myFormula(r'W_S=0.621945\frac{p_{ws}}{p-p_{ws}}', '21'),
            mySimpleLeftText('where'),
            myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myFormulaWhere(r'p_{ws}\:-\:', 'water vapor saturation pressure, psia (Formulas 5 and 6 ASHRAE 2021)'),
            myBlueHeadlineSub('Humidity ratio W, lbw/lbda'),
            myFormula(r'W=\frac{(1093-0.556t^*)W_s^*-0.240(t-t^*)}{1093+0.444t-t^*}', '33'),
            mySimpleLeftText('where'),
            myFormulaWhere(r't^*\:-\:', 'thermodynamic wet-bulb temperature, °F'),
            myFormulaWhere(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myFormulaWhereSub(r'W_s^*\:-\:', 'saturation humidity ratio Ws at a wet-bulb temperature t*, lbw/lbda (Formula 21 ASHRAE 2021)'),
            myBlueHeadlineSub('Partial pressure of water vapor Pw, psia'),
            myFormula(r'W=0.621945\frac{p_w}{p-p_w}', '20'),
            myFormulaWithoutAshrae(r'p_w=\frac{W \times p}{0.621945+W}', '1'),
            mySimpleLeftText('where'),
            myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda(Formula 33 ASHRAE 2021)'),
            myBlueHeadlineSub('Relative humidity ϕ'),
            myFormula(r'\phi=(p_{wv-enh}/p_{wvs-ref}|_{p,t})=[f(p,t_{dp})e(t_{dp})]/[f(p,t_{db})e(t_{db})]', '12'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'p_{wv-enh}\:-\:', 'actual water vapor partial pressure in moist air at the dew-point pressure and temperature, psia (Formula 1)'),
            myFormulaWhereSub(r'p_{wvs-ref}\:-\:', 'reference saturation water vapor partial pressure at the dry-bulb pressure and temperature, psia (Formulas 5 and 6 ASHRAE 2021)'),
            myBlueHeadlineSub('Dew point temperature td, °F'),
            mySimpleLeftText('Between dew points of 32 to 200°F,'),
            myFormula(r't_d=C_{14}+C_{15}\alpha+C_{16}\alpha^2+C_{17}\alpha^3+C_{18}(p_w)^{0.1984}', '37'),
            mySimpleLeftText('Below 32°F,'),
            myFormula(r't_d=90.12+26.142\alpha+0.8927\alpha^2', '38'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'\alpha\:-\:', 'ln pw'),
            myFormulaWhereSub(r'p_w\:-\:', 'water vapor partial pressure, psia (Formula 1)'),
            myFormulaLeft(r'C_{14}=100.45'),
            myFormulaLeft(r'C_{15}=33.193'),
            myFormulaLeft(r'C_{16}=2.319'),
            myFormulaLeft(r'C_{17}=0.17074'),
            myFormulaLeft(r'C_{18}=1.2063'),
            myBlueHeadlineSub('Moist air specific enthalpy h, Btu/lbda'),
            myFormula(r'h=0.240t+W(1061+0.444t)', '30'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myBlueHeadlineSub('Specific volume v, ft3/lbda'),
            myFormula(r'v=0.370486(t+459.67)(1+1.607858W)/p', '26'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myFormulaWhereSub(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myBlueHeadline('Degree of saturation'),
            myFormula(r'\mu=\frac{W}{W_s}', '23'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r'W_s\:-\:', 'saturation humidity ratio at a dry-bulb temperature, lbw/lbda (Formula 21 ASHRAE 2021)'),
          ],
        ),
      ),
      myVerticalOffset(10),

      // Branch #2 Initial data - dry-bulb temperature and dew point temperature
    
      ListTileTheme(
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
            'Initial data - dry-bulb temperature and dew point temperature',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          children: [
            myBlueHeadlineSub('Water vapor saturation pressure Pws, psia'),
            mySimpleJustifyText(
              '\t\t\tThe water vapor saturation pressure is required to determine '
              'a number of moist air properties, principally the saturation humidity '
              'ratio. Values may be calculated from '
              'formulas given by IPAWS R7-97(2012) and R14-08 (2011).\n'
              '\t\t\tThe saturation (sublimation) pressure over ice for the temperature '
              'range of -148 to 32°F is given by'
            ),
            myFormula(r'\mathrm{ln\:}p_{ws}=C_1/T+C_2+C_3T+C_4T^2+C_5T^3+C_6T^4+C_7\:{ln\:}T', '5'),
            mySimpleLeftText('where'),
            myFormulaLeft(r'C_1=-1.0214165\:\mathrm{E}\text{+}04'),
            myFormulaLeft(r'C_2=-4.8932428\:\mathrm{E}\text{+}00'),
            myFormulaLeft(r'C_3=-5.3765794\:\mathrm{E}\text{-}03'),
            myFormulaLeft(r'C_4=1.9202377\:\mathrm{E}\text{-}07'),
            myFormulaLeft(r'C_5=3.5575832\:\mathrm{E}\text{-}10'),
            myFormulaLeft(r'C_6=-9.0344688\:\mathrm{E}\text{-}14'),
            myFormulaLeft(r'C_7=4.1635019\:\mathrm{E}\text{+}00'),
            mySimpleJustifyText(
              '\t\t\tThe saturation pressure over liquid water for the '
              'temperature range of 32 to 392°F is given by'
            ),
            myFormula(r'\mathrm{ln\:}p_{ws}=C_8/T+C_9+C_{10}T+C_{11}T^2+C_{12}T^3+C_{13}\:{ln\:}T', '6'),
            mySimpleLeftText('where'),
            myFormulaLeft(r'C_8=-1.0440397\:\mathrm{E}\text{+}04'),
            myFormulaLeft(r'C_9=-1.1294650\:\mathrm{E}\text{+}01'),
            myFormulaLeft(r'C_{10}=-2.7022355\:\mathrm{E}\text{-}02'),
            myFormulaLeft(r'C_{11}=1.2890360\:\mathrm{E}\text{-}05'),
            myFormulaLeft(r'C_{12}=-2.4780681\:\mathrm{E}\text{-}09'),
            myFormulaLeft(r'C_{13}=6.5459673\:\mathrm{E}\text{+}00'),
            myFormulaWhere(r'T\:-\:', 'absolute temperature, °R = °F + 459.67'),             
            myBlueHeadlineSub('Humidity ratio W, lbw/lbda'),
            myFormula(r'W=0.621945\frac{p_w}{p-p_w}', '20'),
            mySimpleLeftText('where'),
            myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myFormulaWhere(r'p_w\:-\:', 'water vapor partial pressure at a dew point temperature, psia (Formulas 5 and 6 ASHRAE 2021 )'),
            myBlueHeadlineSub('Saturation humidity ratio Ws, lbw/lbda'),
            myFormula(r'W_S=0.621945\frac{p_{ws}}{p-p_{ws}}', '21'),
            mySimpleLeftText('where'),
            myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myFormulaWhere(r'p_{ws}\:-\:', 'water vapor saturation pressure, psia (Formulas 5 and 6 ASHRAE 2021)'),
            myBlueHeadlineSub('Wet bulb temperature td, °F'),
            mySimpleLeftText('Solution of equation 33 by iteration method'),
            myFormula(r'W=\frac{(1093-0.556t^*)W_s^*-0.240(t-t^*)}{1093+0.444t-t^*}', '33'),
            mySimpleLeftText('where'),
            myFormulaWhere(r't^*\:-\:', 'thermodynamic wet-bulb temperature, °F'),
            myFormulaWhere(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myFormulaWhereSub(r'W_s^*\:-\:', 'saturation humidity ratio Ws at a wet-bulb temperature t*, lbw/lbda (Formula 21 ASHRAE 2021)'),
            mySimpleLeftTextHead('Algorithm:'),
            mySimpleLeftText('td - lower limit, tdb - upper limit'),
            mySimpleLeftText('1) twb = (lower limit + upper limit) / 2'),
            mySimpleLeftText('2) calculate Ws (Formula 33 ASHRAE 2021)'),
            mySimpleLeftText('3) if Ws > W -> upper limit = twb, if Ws <= W -> lower limit = twb'),
            mySimpleLeftText('4) back to step 1 as long as the difference between the lower and upper limit is greater than 0.001'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 20 ASHRAE 2021)'),
            myFormulaWhereSub(r'W_s\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhere(r't_d\:-\:', 'dew-point temperature, °F'),
            myFormulaWhere(r't_{wb}\:-\:', 'thermodynamic wet-bulb temperature, °F'),
            myBlueHeadlineSub('Relative humidity ϕ'),
            myFormula(r'\phi=(p_{wv-enh}/p_{wvs-ref}|_{p,t})=[f(p,t_{dp})e(t_{dp})]/[f(p,t_{db})e(t_{db})]', '12'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'p_{wv-enh}\:-\:', 'actual water vapor partial pressure in moist air at the dew-point pressure and temperature, psia (Formulas 5 and 6 ASHRAE 2021)'),
            myFormulaWhereSub(r'p_{wvs-ref}\:-\:', 'reference saturation water vapor partial pressure at the dry-bulb pressure and temperature, psia (Formulas 5 and 6 ASHRAE 2021)'),
            myBlueHeadlineSub('Moist air specific enthalpy h, Btu/lbda'),
            myFormula(r'h=0.240t+W(1061+0.444t)', '30'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myBlueHeadlineSub('Specific volume v, ft3/lbda'),
            myFormula(r'v=0.370486(t+459.67)(1+1.607858W)/p', '26'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myFormulaWhereSub(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myBlueHeadline('Degree of saturation'),
            myFormula(r'\mu=\frac{W}{W_s}', '23'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r'W_s\:-\:', 'saturation humidity ratio at a dry-bulb temperature, lbw/lbda (Formula 21 ASHRAE 2021)'),
          ],
        ),
      ),
      myVerticalOffset(10),

      // Branch #3 Initial data - dry-bulb temperature and relative humidity

      ListTileTheme(
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
            'Initial data - dry-bulb temperature and relative humidity',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          children: [
            myBlueHeadlineSub('Water vapor saturation pressure Pws, psia'),
            mySimpleJustifyText(
              '\t\t\tThe water vapor saturation pressure is required to determine '
              'a number of moist air properties, principally the saturation humidity '
              'ratio. Values may be calculated from '
              'formulas given by IPAWS R7-97(2012) and R14-08 (2011).\n'
              '\t\t\tThe saturation (sublimation) pressure over ice for the temperature '
              'range of -148 to 32°F is given by'
            ),
            myFormula(r'\mathrm{ln\:}p_{ws}=C_1/T+C_2+C_3T+C_4T^2+C_5T^3+C_6T^4+C_7\:{ln\:}T', '5'),
            mySimpleLeftText('where'),
            myFormulaLeft(r'C_1=-1.0214165\:\mathrm{E}\text{+}04'),
            myFormulaLeft(r'C_2=-4.8932428\:\mathrm{E}\text{+}00'),
            myFormulaLeft(r'C_3=-5.3765794\:\mathrm{E}\text{-}03'),
            myFormulaLeft(r'C_4=1.9202377\:\mathrm{E}\text{-}07'),
            myFormulaLeft(r'C_5=3.5575832\:\mathrm{E}\text{-}10'),
            myFormulaLeft(r'C_6=-9.0344688\:\mathrm{E}\text{-}14'),
            myFormulaLeft(r'C_7=4.1635019\:\mathrm{E}\text{+}00'),
            mySimpleJustifyText(
              '\t\t\tThe saturation pressure over liquid water for the '
              'temperature range of 32 to 392°F is given by'
            ),
            myFormula(r'\mathrm{ln\:}p_{ws}=C_8/T+C_9+C_{10}T+C_{11}T^2+C_{12}T^3+C_{13}\:{ln\:}T', '6'),
            mySimpleLeftText('where'),
            myFormulaLeft(r'C_8=-1.0440397\:\mathrm{E}\text{+}04'),
            myFormulaLeft(r'C_9=-1.1294650\:\mathrm{E}\text{+}01'),
            myFormulaLeft(r'C_{10}=-2.7022355\:\mathrm{E}\text{-}02'),
            myFormulaLeft(r'C_{11}=1.2890360\:\mathrm{E}\text{-}05'),
            myFormulaLeft(r'C_{12}=-2.4780681\:\mathrm{E}\text{-}09'),
            myFormulaLeft(r'C_{13}=6.5459673\:\mathrm{E}\text{+}00'),
            myFormulaWhere(r'T\:-\:', 'absolute temperature, °R = °F + 459.67'),
            myBlueHeadlineSub('Saturation pressure of water vapor\nin the absence of air Pw, psia'),
            myFormula(r'\phi=(p_{wv-enh}/p_{wvs-ref}|_{p,t})=[f(p,t_{dp})e(t_{dp})]/[f(p,t_{db})e(t_{db})]', '12'),
            myFormulaWithoutAshrae(r'p_w=\phi \times p_{ws}', '1'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'\phi\:-\:', 'relative humidity'),
            myFormulaWhereSub(r'p_{ws}\:-\:', 'water vapor saturation pressure at a dry bulb temperature, psia (Formulas 5 and 6 ASHRAE 2021 )'),
            myBlueHeadlineSub('Humidity ratio W, lbw/klbda'),
            myFormula(r'W=0.621945\frac{p_w}{p-p_w}', '20'),
            mySimpleLeftText('where'),
            myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myFormulaWhere(r'p_w\:-\:', 'partial pressure of water vapor, psia (Formula 1)'),
            myBlueHeadlineSub('Dew point temperature td, °F'),
            mySimpleLeftText('Between dew points of 32 to 200°F,'),
            myFormula(r't_d=C_{14}+C_{15}\alpha+C_{16}\alpha^2+C_{17}\alpha^3+C_{18}(p_w)^{0.1984}', '37'),
            mySimpleLeftText('Below 32°F,'),
            myFormula(r't_d=90.12+26.142\alpha+0.8927\alpha^2', '38'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'\alpha\:-\:', 'ln pw'),
            myFormulaWhereSub(r'p_w\:-\:', 'water vapor partial pressure, psia (Formula 1)'),
            myFormulaLeft(r'C_{14}=100.45'),
            myFormulaLeft(r'C_{15}=33.193'),
            myFormulaLeft(r'C_{16}=2.319'),
            myFormulaLeft(r'C_{17}=0.17074'),
            myFormulaLeft(r'C_{18}=1.2063'),
            myBlueHeadlineSub('Saturation humidity ratio Ws, lbw/lbda'),
            myFormula(r'W_S=0.621945\frac{p_{ws}}{p-p_{ws}}', '21'),
            mySimpleLeftText('where'),
            myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myFormulaWhere(r'p_{ws}\:-\:', 'water vapor saturation pressure, psia (Formulas 5 and 6 ASHRAE 2021)'),
            myBlueHeadlineSub('Wet bulb temperature td, °F'),
            mySimpleLeftText('Solution of equation 33 by iteration method'),
            myFormula(r'W=\frac{(1093-0.556t^*)W_s^*-0.240(t-t^*)}{1093+0.444t-t^*}', '33'),
            mySimpleLeftText('where'),
            myFormulaWhere(r't^*\:-\:', 'thermodynamic wet-bulb temperature, °F'),
            myFormulaWhere(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myFormulaWhereSub(r'W_s^*\:-\:', 'saturation humidity ratio Ws at a wet-bulb temperature t*, lbw/lbda (Formula 21 ASHRAE 2021)'),
            mySimpleLeftTextHead('Algorithm:'),
            mySimpleLeftText('td - lower limit, tdb - upper limit'),
            mySimpleLeftText('1) twb = (lower limit + upper limit) / 2'),
            mySimpleLeftText('2) calculate Ws (Formula 33 ASHRAE 2021)'),
            mySimpleLeftText('3) if Ws > W -> upper limit = twb, if Ws <= W -> lower limit = twb'),
            mySimpleLeftText('4) back to step 1 as long as the difference between the lower and upper limit is greater than 0.001'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 20 ASHRAE 2021)'),
            myFormulaWhereSub(r'W_s\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhere(r't_d\:-\:', 'dew-point temperature, °F'),
            myFormulaWhere(r't_{wb}\:-\:', 'thermodynamic wet-bulb temperature, °F'),
            myBlueHeadlineSub('Moist air specific enthalpy h, Btu/lbda'),
            myFormula(r'h=0.240t+W(1061+0.444t)', '30'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myBlueHeadlineSub('Specific volume v, ft3/lbda'),
            myFormula(r'v=0.370486(t+459.67)(1+1.607858W)/p', '26'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °F'),
            myFormulaWhereSub(r'p\:-\:', 'barometric pressure of atmospheric air, psia (Formula 3 ASHRAE 2021)'),
            myBlueHeadline('Degree of saturation'),
            myFormula(r'\mu=\frac{W}{W_s}', '23'),
            mySimpleLeftText('where'),
            myFormulaWhereSub(r'W\:-\:', 'humidity ratio, lbw/lbda (Formula 33 ASHRAE 2021)'),
            myFormulaWhereSub(r'W_s\:-\:', 'saturation humidity ratio at a dry-bulb temperature, lbw/lbda (Formula 21 ASHRAE 2021)'),
          ],
        ),
      ),
      myVerticalOffset(10),
      informationTextConv(),    // Text from information_text_converting.dart
    ],
  );
}