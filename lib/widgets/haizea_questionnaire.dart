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
  DevelopmentArea(
    name: 'Lenguaje y Lógica Matemática',
    actions: [
      DevelopmentAction(
        name: "Atiende a conversación",
        startMonth: 2,
        middleLine: 2.25,
        endMonth: 4.75,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Ríe a carcajadas",
        startMonth: 2.5,
        middleLine: 3.5,
        endMonth: 5.5,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Balbucea",
        startMonth: 5,
        middleLine: 6.25,
        endMonth: 8,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Dice inespecíficamente 'mamá, papá'",
        startMonth: 7.5,
        middleLine: 8.75,
        endMonth: 9.5,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Comprende una prohibición",
        startMonth: 8.25,
        middleLine: 10.25,
        endMonth: 15,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Reconoce su nombre",
        startMonth: 9,
        middleLine: 10.5,
        endMonth: 12,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Comprende significado de palabras",
        startMonth: 10,
        middleLine: 11.25,
        endMonth: 13.75,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Obedece orden por gestos",
        startMonth: 10.5,
        middleLine: 11.25,
        endMonth: 18.5,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "PÉRDIDA DE BALBUCEO",
        startMonth: 12,
        middleLine: null,
        endMonth: 23,
        isAlertSign: true,
      ),
      DevelopmentAction(
        name: "Mamá/Papá",
        startMonth: 11.5,
        middleLine: 13,
        endMonth: 16,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Utiliza palabra 'NO'",
        startMonth: 17,
        middleLine: 20,
        endMonth: 24,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Señala partes de su cuerpo",
        startMonth: 17,
        middleLine: 21,
        endMonth: 24,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Nombra objeto dibujado",
        startMonth: 19,
        middleLine: 22,
        endMonth: 25,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Ejecuta 2 órdenes",
        startMonth: 19,
        middleLine: 22,
        endMonth: 25,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Combina 2 palabras",
        startMonth: 21,
        middleLine: 23,
        endMonth: 25,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Utiliza pronombres",
        startMonth: 22,
        middleLine: 23,
        endMonth: 36,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Nombra 5 imágenes",
        startMonth: 24,
        middleLine: 28,
        endMonth: 33,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Indica objetos por el uso",
        startMonth: 25,
        middleLine: 29,
        endMonth: 35,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "ESTEROTIPIAS VERB.",
        startMonth: 24,
        middleLine: null,
        endMonth: 32.5,
        isAlertSign: true,
      ),
      DevelopmentAction(
        name: "Frases de 3 palabras",
        startMonth: 27,
        middleLine: 31,
        endMonth: 34,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Memoriza imágen sencilla",
        startMonth: 27,
        middleLine: 31,
        endMonth: 39,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Cuenta hasta 2",
        startMonth: 29,
        middleLine: 35,
        endMonth: 41,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Nombra diez imágenes",
        startMonth: 29,
        middleLine: 34,
        endMonth: 41,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Usa verbo ser",
        startMonth: 30,
        middleLine: 35,
        endMonth: 43,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Responde coherentemente",
        startMonth: 34,
        middleLine: 41,
        endMonth: 47,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Reconoce colores",
        startMonth: 37,
        middleLine: 41,
        endMonth: 44,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Discrimina largo/corto",
        startMonth: 33,
        middleLine: 36,
        endMonth: 44,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Realiza acciones inconexas",
        startMonth: 37,
        middleLine: 43,
        endMonth: 50,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Denomina colores",
        startMonth: 40,
        middleLine: 44,
        endMonth: 51,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Discrimina mañana/tarde",
        startMonth: 44,
        middleLine: 50,
        endMonth: 57,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Cuenta historias",
        startMonth: 49,
        middleLine: 55,
        endMonth: 59,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Repite frases",
        startMonth: 53,
        middleLine: null,
        endMonth: 59,
        isAlertSign: false,
      ),
      DevelopmentAction(
        name: "Reconoce números",
        startMonth: 53,
        middleLine: null,
        endMonth: 59,
        isAlertSign: false,
      ),
    ] 
  )
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
