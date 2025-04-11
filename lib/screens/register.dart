import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:young/widgets/input.dart';
import 'package:young/widgets/selection_input.dart';
import 'package:young/widgets/button.dart';
import '../utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Logo at the top left
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/Logo.png', // Replace with your logo asset path
                height: 130,
              ),
            ),
          ),
          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Introduzca los datos del paciente:',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Name input
                  SizedBox(
                    width: 600, // Constrain the width of the input
                    child: Input(
                      type: 'name',
                      label: 'Nombre del Paciente',
                      controller: nameController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Age and Gender inputs on the same line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Date of Birth input
                      SizedBox(
                        width: 290, // Constrain the width of the input
                        child: Input(
                          type: 'dob',
                          label: 'Fecha de Nacimiento',
                          controller: dobController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Gender selection input
                      SizedBox(
                        width: 290, // Constrain the width of the input
                        child: SelectionInput(
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Bottom buttons in the same space as inputs
                  SizedBox(
                    width:
                        600, // Constrain the width of the buttons to match inputs
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Salir button
                        SizedBox(
                          width: 290, // Match the width of the inputs
                          child: Button(
                            type: 'option',
                            label: 'Salir',
                            color: 'secondary',
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                          ),
                        ),
                        // Siguiente button
                        SizedBox(
                          width: 290, // Match the width of the inputs
                          child: Button(
                            type: 'option',
                            label: 'Siguiente',
                            color: 'primary',
                            onPressed: () {
                              if (nameController.text.isEmpty ||
                                  dobController.text.isEmpty ||
                                  gender.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Por favor, complete todos los datos.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final int ageInMonths = calculateAgeInMonths(
                                dobController.text,
                              );

                              Navigator.pushNamed(
                                context,
                                '/questionnaire',
                                arguments: {
                                  'name': nameController.text,
                                  'age': ageInMonths,
                                  'gender': gender,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int calculateAgeInMonths(String dob) {
    final DateTime birthDate = DateFormat('dd-MM-yyyy').parse(dob);
    final DateTime today = DateTime.now();

    final int years = today.year - birthDate.year;
    final int months = today.month - birthDate.month;

    return (years * 12) + months;
  }
}
