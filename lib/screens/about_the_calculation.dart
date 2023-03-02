import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hvac_calc/main.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

int? initialIndexAbout = 0;
var labelAbout1 = 0;
var labelAbout2 = 1;

class AboutTheCalculation extends StatefulWidget {
  const AboutTheCalculation({super.key});

  @override
  State<AboutTheCalculation> createState() => _InformationState();
}

class _InformationState extends State<AboutTheCalculation> {

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
              EasyRichTextPattern(
                matchOption: 'last',
                stringBeforeTarget: 'P',
                matchWordBoundaries: false,
                subScript: true,
                targetString: 'a',
                style: TextStyle(color: AppTheme.colors.font1),
              ),
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
            ],
          ),
        ),
      ),
    );
  }

  

  Widget myVerticalOffset (double size) {
    return SizedBox(
      height: size,
    );
  }

  Widget mySimpleLeftText (String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 13),),
    );
  }

  Widget mySimpleLeftTextHead (String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
    );
  }

  Widget mySimpleJustifyText (String text) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      alignment: Alignment.centerLeft,
      child: Text(text, textAlign: TextAlign.justify, style: const TextStyle(fontSize: 13)),
    );
  }

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
              ],
            ),
            ),
          ],
        ),
    );
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
                  setState(() {initialIndexAbout = 0;});
                }
              },
            ),
              myVerticalOffset(10),
              myBlueHeadline('Pressure, kPa'),
              myFormula(r'p = 101.325(1-2.25577 \times 10^{-5}Z)^{5.2559}', '3'),
              mySimpleLeftText('where'),
              myFormulaWhere(r'Z\:-\:', 'altitude, m'),
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
                    myBlueHeadlineSub('Water vapor saturation pressure Pws, Pa'),
                    mySimpleJustifyText(
                      '\t\t\tThe water vapor saturation pressure is required to determine'
                      'a number of moist air properties, principally the saturation humidity'
                      'ratio. Values may be calculated from'
                      'formulas given by IPAWS R7-97(2012) and R14-08 (2011). '
                      'The saturation (sublimation) pressure over ice for the temperature'
                      'range of -100 to 0°C is given by'
                    ),
                    myFormula(r'\mathrm{ln\:}p_{ws}=C_1/T+C_2+C_3/T+C_4/T^2+C_5/T^3+C_6/T^4+C_7\:{ln\:}T', '5'),
                    mySimpleLeftText('where'),
                    myFormulaLeft(r'C_1=-5.6745359\:\mathrm{E}\text{+}03'),
                    myFormulaLeft(r'C_2=6.3925247\:\mathrm{E}\text{+}00'),
                    myFormulaLeft(r'C_3=-9.6778430\:\mathrm{E}\text{-}03'),
                    myFormulaLeft(r'C_4=6.2215701\:\mathrm{E}\text{-}07'),
                    myFormulaLeft(r'C_5=2.0747825\:\mathrm{E}\text{-}09'),
                    myFormulaLeft(r'C_6=-9.4840240\:\mathrm{E}\text{-}13'),
                    myFormulaLeft(r'C_7=4.1635019\:\mathrm{E}\text{+}00'),
                    mySimpleJustifyText(
                      '\t\t\tThe saturation pressure over liquid water for the'
                      'temperature range of 0 to 200°С is given by'
                    ),
                    myFormula(r'\mathrm{ln\:}p_{ws}=C_8/T+C_9+C_{10}/T+C_{11}/T^2+C_{12}/T^3+C_{13}\:{ln\:}T', '6'),
                    mySimpleLeftText('where'),
                    myFormulaLeft(r'C_8=-5.8002206\:\mathrm{E}\text{+}03'),
                    myFormulaLeft(r'C_9=1.3914993\:\mathrm{E}\text{+}00'),
                    myFormulaLeft(r'C_{10}=-4.8640239\:\mathrm{E}\text{-}02'),
                    myFormulaLeft(r'C_{11}=4.1764768\:\mathrm{E}\text{-}05'),
                    myFormulaLeft(r'C_{12}=-1.4452093\:\mathrm{E}\text{-}08'),
                    myFormulaLeft(r'C_{13}=6.5459673\:\mathrm{E}\text{+}00'),
                    myFormulaWhere(r'T\:-\:', 'absolute temperature, K = °C + 273.15'),
                    myBlueHeadlineSub('Saturation humidity ratio Ws, kgw/kgda'),
                    myFormula(r'W_S=0.621945\frac{p_{ws}}{p-p_{ws}}', '21'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myFormulaWhere(r'p_{ws}\:-\:', 'water vapor saturation pressure, Pa (Formulas 5 and 6 ASHRAE 2021)'),
                    myBlueHeadlineSub('Humidity ratio W, kgw/kgda'),
                    myFormula(r'W=\frac{(2501-2.326t^*)W_s^*-1.006(t-t^*)}{2501+1.86t-4.186t^*}', '35'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r't^*\:-\:', 'thermodynamic wet-bulb temperature, °C'),
                    myFormulaWhere(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myFormulaWhereSub(r'W_s^*\:-\:', 'saturation humidity ratio Ws at a wet-bulb temperature t*, kgw/kgda (Formula 21 ASHRAE 2021)'),
                    myBlueHeadlineSub('Partial pressure of water vapor Pw, Pa'),
                    myFormula(r'W=0.621945\frac{p_w}{p-p_w}', '20'),
                    myFormula(r'p_w=\frac{W \times p}{0.621945+W}', '1'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda(Formulas 35 ASHRAE 2021)'),
                    myBlueHeadlineSub('Relative humidity ϕ'),
                    myFormula(r'\phi=(p_{wv-enh}/p_{wvs-ref}|_{p,t})=[f(p,t_{dp})e(t_{dp})]/[f(p,t_{db})e(t_{db})]', '12'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'p_{wv-enh}\:-\:', 'actual water vapor partial pressure in moist air at the dew-point pressure and temperature, Pa (Formula 1)'),
                    myFormulaWhereSub(r'p_{wvs-ref}\:-\:', 'reference saturation water vapor partial pressure at the dry-bulb pressure and temperature, Pa (Formulas 5 and 6 ASHRAE 2021)'),
                    myBlueHeadlineSub('Dew point temperature td, °C'),
                    mySimpleLeftText('Between dew points of 0 and 93°C,'),
                    myFormula(r't_d=C_{14}+C_{15}\alpha+C_{16}\alpha^2+C_{17}\alpha^3+C_{18}(p_w)^{0.1984}', '37'),
                    mySimpleLeftText('Below 0°C,'),
                    myFormula(r't_d=6.09+12.608\alpha+0.4959\alpha^2', '38'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'\alpha\:-\:', 'ln pw'),
                    myFormulaWhereSub(r'p_w\:-\:', 'water vapor partial pressure, kPa (Formula 1)'),
                    myFormulaLeft(r'C_{14}=6.54'),
                    myFormulaLeft(r'C_{15}=14.526'),
                    myFormulaLeft(r'C_{16}=0.7389'),
                    myFormulaLeft(r'C_{17}=0.09486'),
                    myFormulaLeft(r'C_{18}=0.4569'),
                    myBlueHeadlineSub('Moist air specific enthalpy h, kJ/kgda'),
                    myFormula(r'h=1.006t+W(2501+1.86t)', '30'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myBlueHeadlineSub('Specific volume v, m3/kgda'),
                    myFormula(r'v=0.287042(t+273.15)(1+1.607858W)/p', '26'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myFormulaWhereSub(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myBlueHeadline('Degree of saturation'),
                    myFormula(r'\mu=\frac{W}{W_s}', '23'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r'W_s\:-\:', 'saturation humidity ratio at a dry-bulb temperature t , kgw/kgda (Formula 21 ASHRAE 2021)'),
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
                    myBlueHeadlineSub('Water vapor saturation pressure Pws, Pa'),
                    mySimpleJustifyText(
                      '\t\t\tThe water vapor saturation pressure is required to determine'
                      'a number of moist air properties, principally the saturation humidity'
                      'ratio. Values may be calculated from'
                      'formulas given by IPAWS R7-97(2012) and R14-08 (2011). '
                      'The saturation (sublimation) pressure over ice for the temperature'
                      'range of -100 to 0°C is given by'
                    ),
                    myFormula(r'\mathrm{ln\:}p_{ws}=C_1/T+C_2+C_3/T+C_4/T^2+C_5/T^3+C_6/T^4+C_7\:{ln\:}T', '5'),
                    mySimpleLeftText('where'),
                    myFormulaLeft(r'C_1=-5.6745359\:\mathrm{E}\text{+}03'),
                    myFormulaLeft(r'C_2=6.3925247\:\mathrm{E}\text{+}00'),
                    myFormulaLeft(r'C_3=-9.6778430\:\mathrm{E}\text{-}03'),
                    myFormulaLeft(r'C_4=6.2215701\:\mathrm{E}\text{-}07'),
                    myFormulaLeft(r'C_5=2.0747825\:\mathrm{E}\text{-}09'),
                    myFormulaLeft(r'C_6=-9.4840240\:\mathrm{E}\text{-}13'),
                    myFormulaLeft(r'C_7=4.1635019\:\mathrm{E}\text{+}00'),
                    mySimpleJustifyText(
                      '\t\t\tThe saturation pressure over liquid water for the'
                      'temperature range of 0 to 200°С is given by'
                    ),
                    myFormula(r'\mathrm{ln\:}p_{ws}=C_8/T+C_9+C_{10}/T+C_{11}/T^2+C_{12}/T^3+C_{13}\:{ln\:}T', '6'),
                    mySimpleLeftText('where'),
                    myFormulaLeft(r'C_8=-5.8002206\:\mathrm{E}\text{+}03'),
                    myFormulaLeft(r'C_9=1.3914993\:\mathrm{E}\text{+}00'),
                    myFormulaLeft(r'C_{10}=-4.8640239\:\mathrm{E}\text{-}02'),
                    myFormulaLeft(r'C_{11}=4.1764768\:\mathrm{E}\text{-}05'),
                    myFormulaLeft(r'C_{12}=-1.4452093\:\mathrm{E}\text{-}08'),
                    myFormulaLeft(r'C_{13}=6.5459673\:\mathrm{E}\text{+}00'),
                    myFormulaWhere(r'T\:-\:', 'absolute temperature, K = °C + 273.15'),             
                    myBlueHeadlineSub('Humidity ratio W, kgw/kgda'),
                    myFormula(r'W=0.621945\frac{p_w}{p-p_w}', '20'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myFormulaWhere(r'p_w\:-\:', 'water vapor partial pressure at a dew point temperature, Pa (Formulas 5 and 6 ASHRAE 2021 )'),
                    myBlueHeadlineSub('Saturation humidity ratio Ws, kgw/kgda'),
                    myFormula(r'W_S=0.621945\frac{p_{ws}}{p-p_{ws}}', '21'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myFormulaWhere(r'p_{ws}\:-\:', 'water vapor saturation pressure, Pa (Formulas 5 and 6 ASHRAE 2021)'),
                    myBlueHeadlineSub('Wet bulb temperature td, °C'),
                    mySimpleLeftText('Solution of equation 35 by iteration method'),
                    myFormula(r'W=\frac{(2501-2.326t^*)W_s^*-1.006(t-t^*)}{2501+1.86t-4.186t^*}', '35'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r't^*\:-\:', 'thermodynamic wet-bulb temperature, °C'),
                    myFormulaWhere(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myFormulaWhereSub(r'W_s^*\:-\:', 'saturation humidity ratio Ws at a wet-bulb temperature t*, kgw/kgda (Formula 21 ASHRAE 2021)'),
                    myVerticalOffset(10),
                    mySimpleLeftTextHead('Algorithm:'),
                    mySimpleLeftText('td - lower limit, tdb - upper limit'),
                    mySimpleLeftText('1) twb = (lower limit + upper limit) / 2'),
                    mySimpleLeftText('2) calculate Ws (Formula 35 ASHRAE 2021)'),
                    mySimpleLeftText('3) if Ws > W -> upper limit = twb, if Ws <= W -> lower limit = twb'),
                    mySimpleLeftText('4) back to step 1 as long as the difference between the lower and upper limit is greater than 0.001'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio , kgw/kgda (Formula 20 ASHRAE 2021)'),
                    myFormulaWhereSub(r'W_s\:-\:', 'humidity ratio , kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhere(r't_d\:-\:', 'dew-point temperature , °C'),
                    myFormulaWhere(r't_{wb}\:-\:', 'thermodynamic wet-bulb temperature, °C'),
                    myBlueHeadlineSub('Relative humidity ϕ'),
                    myFormula(r'\phi=(p_{wv-enh}/p_{wvs-ref}|_{p,t})=[f(p,t_{dp})e(t_{dp})]/[f(p,t_{db})e(t_{db})]', '12'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'p_{wv-enh}\:-\:', 'actual water vapor partial pressure in moist air at the dew-point pressure and temperature, Pa (Formulas 5 and 6 ASHRAE 2021)'),
                    myFormulaWhereSub(r'p_{wvs-ref}\:-\:', 'reference saturation water vapor partial pressure at the dry-bulb pressure and temperature, Pa (Formulas 5 and 6 ASHRAE 2021)'),
                    myBlueHeadlineSub('Moist air specific enthalpy h, kJ/kgda'),
                    myFormula(r'h=1.006t+W(2501+1.86t)', '30'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myBlueHeadlineSub('Specific volume v, m3/kgda'),
                    myFormula(r'v=0.287042(t+273.15)(1+1.607858W)/p', '26'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myFormulaWhereSub(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myBlueHeadline('Degree of saturation'),
                    myFormula(r'\mu=\frac{W}{W_s}', '23'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r'W_s\:-\:', 'saturation humidity ratio at a dry-bulb temperature t , kgw/kgda (Formula 21 ASHRAE 2021)'),
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
                    myBlueHeadlineSub('Water vapor saturation pressure Pws, Pa'),
                    mySimpleJustifyText(
                      '\t\t\tThe water vapor saturation pressure is required to determine'
                      'a number of moist air properties, principally the saturation humidity'
                      'ratio. Values may be calculated from'
                      'formulas given by IPAWS R7-97(2012) and R14-08 (2011). '
                      'The saturation (sublimation) pressure over ice for the temperature'
                      'range of -100 to 0°C is given by'
                    ),
                    myFormula(r'\mathrm{ln\:}p_{ws}=C_1/T+C_2+C_3/T+C_4/T^2+C_5/T^3+C_6/T^4+C_7\:{ln\:}T', '5'),
                    mySimpleLeftText('where'),
                    myFormulaLeft(r'C_1=-5.6745359\:\mathrm{E}\text{+}03'),
                    myFormulaLeft(r'C_2=6.3925247\:\mathrm{E}\text{+}00'),
                    myFormulaLeft(r'C_3=-9.6778430\:\mathrm{E}\text{-}03'),
                    myFormulaLeft(r'C_4=6.2215701\:\mathrm{E}\text{-}07'),
                    myFormulaLeft(r'C_5=2.0747825\:\mathrm{E}\text{-}09'),
                    myFormulaLeft(r'C_6=-9.4840240\:\mathrm{E}\text{-}13'),
                    myFormulaLeft(r'C_7=4.1635019\:\mathrm{E}\text{+}00'),
                    mySimpleJustifyText(
                      '\t\t\tThe saturation pressure over liquid water for the'
                      'temperature range of 0 to 200°С is given by'
                    ),
                    myFormula(r'\mathrm{ln\:}p_{ws}=C_8/T+C_9+C_{10}/T+C_{11}/T^2+C_{12}/T^3+C_{13}\:{ln\:}T', '6'),
                    mySimpleLeftText('where'),
                    myFormulaLeft(r'C_8=-5.8002206\:\mathrm{E}\text{+}03'),
                    myFormulaLeft(r'C_9=1.3914993\:\mathrm{E}\text{+}00'),
                    myFormulaLeft(r'C_{10}=-4.8640239\:\mathrm{E}\text{-}02'),
                    myFormulaLeft(r'C_{11}=4.1764768\:\mathrm{E}\text{-}05'),
                    myFormulaLeft(r'C_{12}=-1.4452093\:\mathrm{E}\text{-}08'),
                    myFormulaLeft(r'C_{13}=6.5459673\:\mathrm{E}\text{+}00'),
                    myFormulaWhere(r'T\:-\:', 'absolute temperature, K = °C + 273.15'),
                    myBlueHeadlineSub('Saturation pressure of water vapor\nin the absence of air Pw, Pa'),
                    myFormula(r'\phi=(p_{wv-enh}/p_{wvs-ref}|_{p,t})=[f(p,t_{dp})e(t_{dp})]/[f(p,t_{db})e(t_{db})]', '12'),
                    myFormula(r'p_w=\phi \times p_{ws}', '1'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'\phi', 'relative humidity'),
                    myFormulaWhereSub(r'p_{ws}\:-\:', 'water vapor saturation pressure at a dry bulb temperature, Pa (Formulas 5 and 6 ASHRAE 2021 )'),
                    myBlueHeadlineSub('Humidity ratio W, kgw/kgda'),
                    myFormula(r'W=0.621945\frac{p_w}{p-p_w}', '20'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myFormulaWhere(r'p_w\:-\:', 'partial pressure of water vapor, Pa (Formula 1)'),
                    myBlueHeadlineSub('Dew point temperature td, °C'),
                    mySimpleLeftText('Between dew points of 0 and 93°C,'),
                    myFormula(r't_d=C_{14}+C_{15}\alpha+C_{16}\alpha^2+C_{17}\alpha^3+C_{18}(p_w)^{0.1984}', '37'),
                    mySimpleLeftText('Below 0°C,'),
                    myFormula(r't_d=6.09+12.608\alpha+0.4959\alpha^2', '38'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'\alpha\:-\:', 'ln pw'),
                    myFormulaWhereSub(r'p_w\:-\:', 'water vapor partial pressure, kPa (Formula 1)'),
                    myFormulaLeft(r'C_{14}=6.54'),
                    myFormulaLeft(r'C_{15}=14.526'),
                    myFormulaLeft(r'C_{16}=0.7389'),
                    myFormulaLeft(r'C_{17}=0.09486'),
                    myFormulaLeft(r'C_{18}=0.4569'),
                    myBlueHeadlineSub('Saturation humidity ratio Ws, kgw/kgda'),
                    myFormula(r'W_S=0.621945\frac{p_{ws}}{p-p_{ws}}', '21'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myFormulaWhere(r'p_{ws}\:-\:', 'water vapor saturation pressure, Pa (Formulas 5 and 6 ASHRAE 2021)'),
                    myBlueHeadlineSub('Wet bulb temperature td, °C'),
                    mySimpleLeftText('Solution of equation 35 by iteration method'),
                    myFormula(r'W=\frac{(2501-2.326t^*)W_s^*-1.006(t-t^*)}{2501+1.86t-4.186t^*}', '35'),
                    mySimpleLeftText('where'),
                    myFormulaWhere(r't^*\:-\:', 'thermodynamic wet-bulb temperature, °C'),
                    myFormulaWhere(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myFormulaWhereSub(r'W_s^*\:-\:', 'saturation humidity ratio Ws at a wet-bulb temperature t*, kgw/kgda (Formula 21 ASHRAE 2021)'),
                    myVerticalOffset(10),
                    mySimpleLeftTextHead('Algorithm:'),
                    mySimpleLeftText('td - lower limit, tdb - upper limit'),
                    mySimpleLeftText('1) twb = (lower limit + upper limit) / 2'),
                    mySimpleLeftText('2) calculate Ws (Formula 35 ASHRAE 2021)'),
                    mySimpleLeftText('3) if Ws > W -> upper limit = twb, if Ws <= W -> lower limit = twb'),
                    mySimpleLeftText('4) back to step 1 as long as the difference between the lower and upper limit is greater than 0.001'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio , kgw/kgda (Formula 20 ASHRAE 2021)'),
                    myFormulaWhereSub(r'W_s\:-\:', 'humidity ratio , kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhere(r't_d\:-\:', 'dew-point temperature , °C'),
                    myFormulaWhere(r't_{wb}\:-\:', 'thermodynamic wet-bulb temperature, °C'),
                    myBlueHeadlineSub('Moist air specific enthalpy h, kJ/kgda'),
                    myFormula(r'h=1.006t+W(2501+1.86t)', '30'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myBlueHeadlineSub('Specific volume v, m3/kgda'),
                    myFormula(r'v=0.287042(t+273.15)(1+1.607858W)/p', '26'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r't\:-\:', 'thermodynamic dry-bulb temperature, °C'),
                    myFormulaWhereSub(r'p\:-\:', 'barometric pressure of atmospheric air, Pa (Formula 3 ASHRAE 2021)'),
                    myBlueHeadline('Degree of saturation'),
                    myFormula(r'\mu=\frac{W}{W_s}', '23'),
                    mySimpleLeftText('where'),
                    myFormulaWhereSub(r'W\:-\:', 'humidity ratio W, kgw/kgda (Formula 35 ASHRAE 2021)'),
                    myFormulaWhereSub(r'W_s\:-\:', 'saturation humidity ratio at a dry-bulb temperature t , kgw/kgda (Formula 21 ASHRAE 2021)'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
          
  );
  }
}