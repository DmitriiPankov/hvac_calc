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
        textTheme: const TextTheme(
            headlineMedium: TextStyle(
          fontFamily: 'RobotoMono',
          fontSize: 16,
          color: Color.fromARGB(255, 59, 54, 84),
        )),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 59, 54, 84),
            fontSize: 18,
            fontFamily: 'RobotoMono',
          ),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
