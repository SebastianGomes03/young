import 'package:flutter/material.dart';
import 'package:young/screens/register.dart';
import 'package:young/screens/results.dart';
import 'package:young/utils/routes.dart';
import 'package:young/screens/questionnaire.dart';
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
        Routes.register: (context) => RegisterScreen(),
        Routes.questionnaire: (context) => QuestionnaireScreen(),
        Routes.results: (context) => ResultsScreen(),
      },
      initialRoute: Routes.home,
    );
  }
}
