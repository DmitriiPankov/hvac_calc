import 'package:flutter/material.dart';
import 'package:hvac_calc/colors.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

@immutable
class AppTheme {
  static const colors = AppColors();
  const AppTheme._();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HVAC calc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color.fromARGB(255, 242, 242, 242),
        textTheme: TextTheme(
            headlineMedium: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 15,
              color: AppTheme.colors.font1,
            ),
            headlineLarge: TextStyle(
              shadows: [
                Shadow(
                    color: AppTheme.colors.font1, offset: const Offset(0, -2))
              ],
              fontFamily: 'RobotoMono',
              fontSize: 15,
              color: const Color.fromARGB(0, 3, 35, 76),
              decoration: TextDecoration.underline,
              decorationThickness: 1.0,
              decorationColor: AppTheme.colors.font1,
              decorationStyle: TextDecorationStyle.dotted,
            ),
            headlineSmall: TextStyle(
              shadows: [
                Shadow(
                    color: AppTheme.colors.font1, offset: const Offset(0, -2))
              ],
              fontFamily: 'RobotoMono',
              fontSize: 14,
              color: const Color.fromARGB(0, 3, 35, 76),
              decoration: TextDecoration.underline,
              decorationThickness: 1.0,
              decorationColor: AppTheme.colors.font1,
              decorationStyle: TextDecorationStyle.dotted,
            ),
            displaySmall: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 14,
              color: AppTheme.colors.font1,
            ),
            displayMedium: const TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 12,
              color: Color.fromARGB(255, 198, 0, 0),
            )
          ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: AppTheme.colors.font1),
          foregroundColor: AppTheme.colors.font1,
          titleTextStyle: TextStyle(
            color: AppTheme.colors.font1,
            fontSize: 17,
            fontFamily: 'RobotoMono',
          ),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
