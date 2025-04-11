import 'package:flutter/material.dart';
import '../utils/colors.dart';

class QuestionnaireWidget extends StatefulWidget {
  const QuestionnaireWidget({Key? key}) : super(key: key);

  List<String> getAnswers() {
    final state = _QuestionnaireWidgetState.instance;
    return state?.answers.map((answer) => answer ?? 'No respondida').toList() ??
        [];
  }

  // Public method to validate and calculate score
  bool areAllQuestionsAnswered() {
    final state = _QuestionnaireWidgetState.instance;
    return state != null && !state.answers.contains(null);
  }

  int calculateScore() {
    final state = _QuestionnaireWidgetState.instance;
    return state?._calculateScore() ?? 0;
  }

  String getRiskLevel(int score) {
    final state = _QuestionnaireWidgetState.instance;
    return state?._getRiskLevel(score) ?? 'BAJO';
  }

  @override
  State<QuestionnaireWidget> createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  static _QuestionnaireWidgetState? instance;

  _QuestionnaireWidgetState() {
    instance = this;
  }

  final List<String?> answers = List<String?>.filled(20, null);
  final List<int> specialQuestions = [2, 5, 12];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row
        Container(
          color: colorsPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Preguntas',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  'Sí',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  'No',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Questions list with padding
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                final questionNumber = index + 1;
                final isSpecial = specialQuestions.contains(questionNumber);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // Question label with optional underline
                      Expanded(
                        child: Text(
                          '$questionNumber. Pregunta',
                          style: TextStyle(
                            fontSize: 32,
                            decoration:
                                isSpecial
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                            decorationColor: colorsPrimary,
                            decorationThickness: 2.0,
                          ),
                        ),
                      ),
                      // "Sí" checkbox
                      SizedBox(
                        width: 60, // Match the header size
                        child: Transform.scale(
                          scale: 1.5, // Make checkbox larger
                          child: Checkbox(
                            value: answers[index] == 'yes',
                            onChanged: (bool? value) {
                              setState(() {
                                answers[index] = value == true ? 'yes' : null;
                              });
                            },
                            activeColor: colorsPrimary,
                            side: const BorderSide(
                              color:
                                  colorsPrimary, // Border color when inactive
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      // "No" checkbox
                      SizedBox(
                        width: 60, // Match the header size
                        child: Transform.scale(
                          scale: 1.5, // Make checkbox larger
                          child: Checkbox(
                            value: answers[index] == 'no',
                            onChanged: (bool? value) {
                              setState(() {
                                answers[index] = value == true ? 'no' : null;
                              });
                            },
                            activeColor: colorsPrimary,
                            side: const BorderSide(
                              color:
                                  colorsPrimary, // Border color when inactive
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

    List<String> getAnswers() {
      return answers.map((answer) => answer ?? 'No respondida').toList();
    }

    int _calculateScore() {
      int score = 0;
      for (int i = 0; i < answers.length; i++) {
        if (specialQuestions.contains(i + 1)) {
          if (answers[i] == 'yes') score++;
        } else {
          if (answers[i] == 'no') score++;
        }
      }
      return score;
    }

    String _getRiskLevel(int score) {
      if (score <= 2) {
        return 'BAJO';
      } else if (score <= 7) {
        return 'MEDIO';
      } else {
        return 'ALTO';
      }
    }
}



