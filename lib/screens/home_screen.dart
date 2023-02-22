import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hvac_calc/main.dart';
import 'package:hvac_calc/screens/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colorsTheme = Colors.black;

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
        title: Text(
          'HVAC engineering calculator',
          style: TextStyle(
            fontFamily: 'RobotoMono',
            color: AppTheme.colors.font1,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: const CardWidget(),
    );
  }
}
