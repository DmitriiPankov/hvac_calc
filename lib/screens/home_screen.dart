import 'package:flutter/material.dart';
import 'package:hvac_calc/screens/card_widget.dart';

/* class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('HVAC engineering calculator'),
        ),
        body: Container(),
      ),
    );
  } 
}*/

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
        shadowColor: Colors.transparent,
        /* leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 59, 54, 84),
            size: 25,
          ),
          onPressed: () {},
        ), */
        title: const Text(
          'HVAC engineering calculator',
        ),
        centerTitle: true,
      ),
      body: const CardWidget(),
    );
  }
}
