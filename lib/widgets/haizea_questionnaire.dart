import 'package:flutter/material.dart';
import '../utils/colors.dart';

class DevelopmentAction {
  final String name; // Nombre de la acción
  final double startMonth; // Mes en el que el 50% de los niños realizan la acción
  final double? middleLine; //alertSign actions dont have a middle line
  final double endMonth; // Mes en el que el 95% de los niños realizan la acción
  final bool isAlertSign; // Si es un signo de alerta

  DevelopmentAction({
    required this.name,
    required this.startMonth,
    required this.middleLine,
    required this.endMonth,
    this.isAlertSign = false,
  });
}

class DevelopmentArea {
  final String name; // Name of the area (e.g., "Sociability")
  final List<DevelopmentAction> actions; // List of actions in this area

  DevelopmentArea({required this.name, required this.actions});
}

class ChildDevelopmentEvaluation {
  final int ageInMonths; // Age of the child in months
  final List<DevelopmentArea> areas; // List of all development areas

  ChildDevelopmentEvaluation({required this.ageInMonths, required this.areas});

  // Get actions that the 50% of children should have completed (start line to middle line)
  List<DevelopmentAction> getActions50Percent() {
    List<DevelopmentAction> actions50Percent = [];

    for (var area in areas) {
      for (var action in area.actions) {
        if (action.isAlertSign) {
          continue; // Skip alert sign actions
        }
        if (ageInMonths >= action.startMonth &&
            ageInMonths < action.middleLine!) {
          actions50Percent.add(action);
        }
      }
    }

    return actions50Percent;
  }

  // Get actions that the 75% of children should have completed (middle to end line)
  List<DevelopmentAction> getActions75Percent() {
    List<DevelopmentAction> actions75Percent = [];

    for (var area in areas) {
      for (var action in area.actions) {
        if (action.isAlertSign) {
          continue; // Skip alert sign actions
        }
        if (ageInMonths >= action.middleLine! &&
            ageInMonths < action.endMonth) {
          actions75Percent.add(action);
        }
      }
    }

    return actions75Percent;
  }

  // Get actions that the 95% of children should have completed (end line)
  List<DevelopmentAction> getActions95Percent() {
    List<DevelopmentAction> actions95Percent = [];

    for (var area in areas) {
      for (var action in area.actions) {
        if (action.isAlertSign) {
          continue; // Skip alert sign actions
        }
        if (ageInMonths >= action.endMonth) {
          actions95Percent.add(action);
        }
      }
    }

    return actions95Percent;
  }

  // Get alert sign actions
  List<DevelopmentAction> getAlertSignActions() {
    List<DevelopmentAction> alertSignActions = [];

    for (var area in areas) {
      for (var action in area.actions) {
        if (action.isAlertSign) {
          alertSignActions.add(action);
        }
      }
    }

    return alertSignActions;
  }
}

class HaizeaQuestionnaireWidget extends StatefulWidget {
  const HaizeaQuestionnaireWidget({Key? key}) : super(key: key);

  List<String> getAnswers() {
    final state = _HaizeaQuestionnaireWidgetState.instance;
    return state?.answers.map((answer) => answer ?? 'No respondida').toList() ??
        [];
  }

  bool areAllQuestionsAnswered() {
    final state = _HaizeaQuestionnaireWidgetState.instance;
    return state != null && !state.answers.contains(null);
  }

  int calculateScore() {
    final state = _HaizeaQuestionnaireWidgetState.instance;
    return state?._calculateScore() ?? 0;
  }

  String getRiskLevel(int score) {
    final state = _HaizeaQuestionnaireWidgetState.instance;
    return state?._getRiskLevel(score) ?? 'BAJO';
  }

  @override
  State<HaizeaQuestionnaireWidget> createState() =>
      _HaizeaQuestionnaireWidgetState();
}

final developmentAreas = [
  DevelopmentArea(
    name: 'Socialización',
    actions: [
      DevelopmentAction(
        name: "Reacciona a la voz",
        startMonth: 1,
        middleLine: 1.5,
        endMonth: 3,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Busca objeto caído",
        startMonth: 5.5,
        middleLine: 7,
        endMonth: 8,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Lleva un vaso a la boca",
        startMonth: 12,
        middleLine: 14,
        endMonth: 19,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Se quita los pantalones",
        startMonth: 24,
        middleLine: 26,
        endMonth: 32,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Se quita la camiseta",
        startMonth: 24,
        middleLine: 26,
        endMonth: 32,
        isAlertSign: false,
      ),
    ],
  ),
];

class _HaizeaQuestionnaireWidgetState extends State<HaizeaQuestionnaireWidget> {
  static _HaizeaQuestionnaireWidgetState? instance;

  _HaizeaQuestionnaireWidgetState() {
    instance = this;
  }

  final List<String?> answers = List<String?>.filled(20, null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          questions[index],
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: answers[index] == 'yes',
                            onChanged: (bool? value) {
                              setState(() {
                                answers[index] = value == true ? 'yes' : null;
                              });
                            },
                            activeColor: colorsPrimary,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: answers[index] == 'no',
                            onChanged: (bool? value) {
                              setState(() {
                                answers[index] = value == true ? 'no' : null;
                              });
                            },
                            activeColor: colorsPrimary,
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

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < answers.length; i++) {
      if (answers[i] == 'no') score++;
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
