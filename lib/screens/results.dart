import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../utils/colors.dart';
import '../widgets/button.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(body: Center(child: Text('No arguments provided!')));
    }

    final String patientName = args['patientName'] ?? 'Unknown';
    final int age = args['age'] ?? 0;
    final int score = args['score'] ?? 0;
    final String riskLevel = args['riskLevel'] ?? 'BAJO';
    final List<String> answers = args['answers'] ?? [];

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset('assets/Logo.png', height: 130),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'RESULTADOS',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Agbalumo',
                        fontSize: 32,
                        color: colorsBlack,
                      ),
                      children: [
                        const TextSpan(text: '• El paciente '),
                        TextSpan(
                          text: patientName,
                          style: const TextStyle(color: colorsBlack),
                        ),
                        const TextSpan(text: ' presenta un '),
                        TextSpan(
                          text: '$riskLevel RIESGO',
                          style: const TextStyle(
                            color: colorsPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: ' de padecer TEA.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '• Obtuvo una puntuación total de $score, ${_getScoreMessage(score, age)}',
                    style: const TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        isHovered = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHovered = false;
                      });
                    },
                    child: IconButton(
                      icon: Icon(Icons.download),
                      color: isHovered ? colorsPrimary : colorsBlack,
                      iconSize: 80,
                      onPressed: () async {
                        await _generateAndSavePdf(
                            patientName, age, score, riskLevel, answers);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Button(
                    type: 'option',
                    label: 'Salir',
                    color: 'primary',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreMessage(int score, int age) {
    if (score <= 2) {
      return age < 24
          ? 'el puntaje indica un riesgo bajo. Repetir el cuestionario a los 24 meses.'
          : 'el puntaje indica un riesgo bajo. Ninguna otra medida necesaria a menos que la vigilancia del desarrollo indique riesgo de TEA.';
    } else if (score <= 7) {
      return 'el puntaje indica un riesgo moderado. Remita al niño para una evaluación diagnóstica.';
    } else {
      return 'el puntaje indica un riesgo alto. Remita el caso de inmediato para evaluación diagnóstica.';
    }
  }

  Future<void> _generateAndSavePdf(
    String patientName,
    int age,
    int score,
    String riskLevel,
    List<String> answers,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Resultados del Cuestionario',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Paciente: $patientName',
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.Text('Edad: $age meses', style: pw.TextStyle(fontSize: 16)),
                pw.Text(
                  'Puntuación: $score',
                  style: pw.TextStyle(fontSize: 16),
                ),
                pw.Text(
                  'Nivel de Riesgo: $riskLevel',
                  style: pw.TextStyle(fontSize: 16, color: PdfColors.teal, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Respuestas del Cuestionario:',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                // Iterate over the answers list and add each question and answer
                ...answers.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String answer = entry.value;
                  return pw.Text(
                    'Pregunta ${index + 1}: $answer',
                    style: pw.TextStyle(fontSize: 16),
                  );
                }).toList(),
              ],
            ),
      ),
    );

    // Save the PDF to the device
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/Resultados_$patientName.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('PDF guardado en: ${file.path}')));
  }
}