import 'package:flutter/material.dart';
import 'package:young/utils/routes.dart';
import 'package:young/widgets/m_chart.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';

class MCHATQuestionnaireScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      return Scaffold(body: Center(child: Text('No arguments provided!')));
    }

    final String patientName = args['name'] ?? 'Unknown';
    final int age = args['age'] ?? 0;

    final questionnaireWidget = const QuestionnaireWidget();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo at the top left
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/Logo.png', // Replace with your logo asset path
                height: 130,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Centered title
          const Center(
            child: Text(
              'Introduzca las respuestas del cuestionario:',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // Questionnaire widget
          Expanded(child: questionnaireWidget),
          // Submit button at the bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Button(
                type: 'option',
                label: 'Siguiente',
                color: 'primary',
                onPressed: () {
                  // Validate and navigate to results
                  if (!questionnaireWidget.areAllQuestionsAnswered()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Por favor, conteste todas las preguntas.',
                        ),
                      ),
                    );
                    return;
                  }

                  final score = questionnaireWidget.calculateScore();
                  final riskLevel = questionnaireWidget.getRiskLevel(score);
                  final answers = questionnaireWidget.getAnswers();

                  Navigator.pushReplacementNamed(
                    context,
                    Routes.mchatresults,
                    arguments: {
                      ...args,
                      'patientName': patientName,
                      'age': age,
                      'score': score,
                      'riskLevel': riskLevel,
                      'answers': answers,
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
