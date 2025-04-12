import 'package:flutter/material.dart';
import 'package:young/screens/MCHAT/MCHATamnesic_data.dart';
import 'package:young/screens/MCHAT/MCHATregister.dart';
import 'package:young/screens/MCHAT/MCHATresults.dart';
import 'package:young/utils/routes.dart';
import 'package:young/screens/MCHAT/MCHATquestionnaire.dart';
import 'screens/home.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Young App',
      theme: ThemeData(
        fontFamily: 'Agbalumo', // Set Agbalumo as the default font
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: colorsBackground, // Set background color
      ),
      routes: {
        Routes.home: (context) => const HomeScreen(),
        Routes.mchatregister: (context) => MCHATRegisterScreen(),
        Routes.mchatamnesicData: (context) => MCHATAmnesicDataScreen(),
        Routes.mchatquestionnaire: (context) => MCHATQuestionnaireScreen(),
        Routes.mchatresults: (context) => MCHATResultsScreen(),
      },
      initialRoute: Routes.home,
    );
  }
}
