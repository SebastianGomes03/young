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

  final List<String> questions = [
    'Si usted señala algo al otro lado de la habitación, ¿su hijo/a lo mira? (POR EJEMPLO, si usted señala a un juguete, un peluche o un animal, ¿su hijo/a lo mira?)',
    '¿Alguna vez se ha preguntado si su hijo/a es sordo/a?',
    '¿Su hijo/a juega juegos de fantasía o imaginación? (POR EJEMPLO, “hace como que” bebe de una taza vacía, habla por teléfono o da de comer a una muñeca o peluche…)',
    '¿A su hijo/a le gusta subirse a cosas? (POR EJEMPLO, a una silla, escaleras, o tobogán…)',
    '¿Hace su hijo/a movimientos inusuales con sus dedos cerca de sus ojos? (POR EJEMPLO, mueve sus dedos cerca de sus ojos de manera inusual?)',
    '¿Su hijo/a señala con un dedo cuando quiere pedir algo o pedir ayuda? (POR EJEMPLO, señala un juguete o algo de comer que está fuera de su alcance?)',
    '¿Su hijo/a señala con un dedo para mostrarle algo que le llama la atención? (POR EJEMPLO, señala un avión en el cielo o un camión muy grande en la calle)',
    '¿Su hijo/a se interesa en otros niños? (POR EJEMPLO, mira con atención a otros niños, les sonríe o se les acerca?)',
    '¿Su hijo/a le muestra cosas acercándolas o levantándolas para que usted las vea – no para pedir ayuda sino solamente para compartirlas con usted? (POR EJEMPLO, le muestra una flor o un peluche o un coche de juguete?)',
    '¿Su hijo/a responde cuando usted le llama por su nombre? (POR EJEMPLO, se vuelve, habla o balbucea, o deja de hacer lo que estaba haciendo para mirarle?)',
    '¿Cuándo usted sonríe a su hijo/a, él o ella también le sonríe?',
    '¿Le molestan a su hijo/a ruidos cotidianos? (POR EJEMPLO, la aspiradora o la música, incluso cuando está no está excesivamente alta?)',
    '¿Su hijo/a camina solo?',
    '¿Su hijo/a mira a los ojos cuando usted le habla, juega con él o ella, o lo viste?',
    '¿Su hijo/a imita sus movimientos? (POR EJEMPLO, decir adiós con la mano, aplaudir o algún ruido gracioso que usted haga?)',
    'Si usted se gira a ver algo, ¿su hijo/a trata de mirar hacia lo que usted está mirando?',
    '¿Su hijo/a intenta que usted le mire/preste atención? (POR EJEMPLO, busca que usted le haga caso, diciendo o dice “mira” o “mírame”)',
    '¿Su hijo/a le entiende cuando usted le dice que haga algo? (POR EJEMPLO, si usted no hace gestos, ¿su hijo/a entiende “ponte de pie encima de la silla” o “tráeme la manta”?)',
    'Si algo nuevo pasa, ¿su hijo/a le mira para ver cómo usted reacciona al respecto? (POR EJEMPLO, si oye un ruido extraño o ve un juguete nuevo, ¿le gira a ver su cara?)',
    '¿Le gustan a su hijo/a juegos de movimiento? (POR EJEMPLO, le gusta que le balancee, o que le haga “el caballito” sentándole en sus rodillas?)',
  ];

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
              itemCount: questions.length,
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
                          '$questionNumber. ${questions[index]}',
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
