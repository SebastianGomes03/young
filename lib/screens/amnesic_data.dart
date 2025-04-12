import 'package:flutter/material.dart';
import 'package:young/widgets/input.dart';
import 'package:young/widgets/button.dart';
import '../utils/colors.dart';
import 'package:flutter/services.dart';

class AmnesicDataScreen extends StatefulWidget {
  @override
  _AmnesicDataScreenState createState() => _AmnesicDataScreenState();
}

class _AmnesicDataScreenState extends State<AmnesicDataScreen> {
  final TextEditingController perinatalController = TextEditingController();
  final TextEditingController partoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController psicomotorController = TextEditingController();
  final TextEditingController lenguajeController = TextEditingController();
  final TextEditingController esfintarioController = TextEditingController();
  final TextEditingController enfermedadesController = TextEditingController();
  final TextEditingController familiaresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from the previous screen
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(body: Center(child: Text('No arguments provided!')));
    }

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
                    'Introduzca los datos anamnésicos del paciente:',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Datos Perinatales y Post Natales input
                  SizedBox(
                    width: 600,
                    child: Input(
                      type: 'text',
                      label: 'Datos Perinatales y Post Natales',
                      controller: perinatalController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Forma de Parto, Altura al nacer, Peso al nacer inputs in a row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Forma de Parto input
                      SizedBox(
                        width: 190,
                        child: Input(
                          type: 'text',
                          label: 'Forma de Parto',
                          controller: partoController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Altura al nacer input
                      SizedBox(
                        width: 190,
                        child: Input(
                          type: 'number',
                          label: 'Altura al nacer (cm)',
                          controller: alturaController,
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Restrict to numbers only
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Peso al nacer input
                      SizedBox(
                        width: 190,
                        child: Input(
                          type: 'number',
                          label: 'Peso al nacer (kg)',
                          controller: pesoController,
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Restrict to numbers only
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Desarrollo Psicomotor and Desarrollo del Lenguaje inputs
                  SizedBox(
                    width: 600,
                    child: Input(
                      type: 'text',
                      label: 'Desarrollo Psicomotor',
                      controller: psicomotorController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 600,
                    child: Input(
                      type: 'text',
                      label: 'Desarrollo del Lenguaje',
                      controller: lenguajeController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Control Esfintario input
                  SizedBox(
                    width: 600,
                    child: Input(
                      type: 'text',
                      label: 'Control Esfintario',
                      controller: esfintarioController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Enfermedades Padecidas input
                  SizedBox(
                    width: 600,
                    child: Input(
                      type: 'text',
                      label: 'Enfermedades Padecidas',
                      controller: enfermedadesController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Antecedentes Familiares input
                  SizedBox(
                    width: 600,
                    child: Input(
                      type: 'text',
                      label: 'Antecedentes Familiares',
                      controller: familiaresController,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bottom buttons
                  SizedBox(
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Regresar button
                        SizedBox(
                          width: 290,
                          child: Button(
                            type: 'option',
                            label: 'Regresar',
                            color: 'secondary',
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/register',
                                arguments: {...args, 'dob': args['dob']},
                              );
                            },
                          ),
                        ),
                        // Siguiente button
                        SizedBox(
                          width: 290,
                          child: Button(
                            type: 'option',
                            label: 'Siguiente',
                            color: 'primary',
                            onPressed: () {
                              if (perinatalController.text.isEmpty ||
                                  partoController.text.isEmpty ||
                                  alturaController.text.isEmpty ||
                                  pesoController.text.isEmpty ||
                                  psicomotorController.text.isEmpty ||
                                  lenguajeController.text.isEmpty ||
                                  esfintarioController.text.isEmpty ||
                                  enfermedadesController.text.isEmpty ||
                                  familiaresController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Por favor, complete todos los datos.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // Add new inputs to the arguments and navigate to the test screen
                              Navigator.pushNamed(
                                context,
                                '/questionnaire',
                                arguments: {
                                  ...args, // Maintain previous context
                                  'perinatal': perinatalController.text,
                                  'parto': partoController.text,
                                  'altura': alturaController.text,
                                  'peso': pesoController.text,
                                  'psicomotor': psicomotorController.text,
                                  'lenguaje': lenguajeController.text,
                                  'esfintario': esfintarioController.text,
                                  'enfermedades': enfermedadesController.text,
                                  'familiares': familiaresController.text,
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
}
