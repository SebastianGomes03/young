import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import '../../utils/colors.dart';
import '../../widgets/button.dart';

class HAIZEALLEVANT_ResultsScreen extends StatefulWidget {
  @override
  _HAIZEALLEVANT_ResultsScreenState createState() => _HAIZEALLEVANT_ResultsScreenState();
}

class _HAIZEALLEVANT_ResultsScreenState extends State<HAIZEALLEVANT_ResultsScreen> {
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
                          args['patientName'] ?? 'Unknown',
                          args['dob'] ?? 'Unknown',
                          args['age'] ?? 0,
                          args['gender'] ?? 'Unknown',
                          args['escolaridad'] ?? 'Unknown',
                          args['direccion'] ?? 'Unknown',
                          args['telefono'] ?? 'Unknown',
                          args['representante'] ?? 'Unknown',
                          args['perinatal'] ?? 'Unknown',
                          args['parto'] ?? 'Unknown',
                          args['altura'] ?? 'Unknown',
                          args['peso'] ?? 'Unknown',
                          args['psicomotor'] ?? 'Unknown',
                          args['lenguaje'] ?? 'Unknown',
                          args['esfintario'] ?? 'Unknown',
                          args['enfermedades'] ?? 'Unknown',
                          args['familiares'] ?? 'Unknown',
                          args['score'] ?? 0,
                          args['riskLevel'] ?? 'BAJO',
                        );
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
    String dob,
    int age,
    String gender,
    String escolaridad,
    String direccion,
    String telefono,
    String representante,
    String perinatal,
    String parto,
    String altura,
    String peso,
    String psicomotor,
    String lenguaje,
    String esfintario,
    String enfermedades,
    String familiares,
    int score,
    String riskLevel,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build:
            (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Logo and Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(
                      pw.MemoryImage(File('assets/Logo.png').readAsBytesSync()),
                      height: 50,
                    ),
                    pw.SizedBox(width: 16),
                  ],
                ),
                pw.Center(
                  child: pw.Text(
                    'Consultorio Psicológico Integral\nGonzález Calzadilla',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Center(
                  child: pw.Text(
                    'Informe Resultados Screening Riesgo de TEA',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Fecha: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),

                // Patient General Information
                pw.Text(
                  'Datos Generales:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text('Nombre del Paciente: $patientName'),
                pw.Text('F.N.: $dob'),
                pw.Text('Edad: $age meses'),
                pw.Text('Sexo: $gender'),
                pw.Text('Escolaridad: $escolaridad'),
                pw.Text('Teléfono: $telefono'),
                pw.Text('Dirección: $direccion'),
                pw.Text('Representante: $representante'),
                pw.SizedBox(height: 16),

                // Anamnesic Data
                pw.Text(
                  'Datos Anamnésicos:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'Datos Perinatales y Post Natales Importantes: $perinatal',
                ),
                pw.Text('Forma de Parto: $parto'),
                pw.Text('Midió al nacer: $altura cm'),
                pw.Text('Pesó al nacer: $peso kg'),
                pw.Text('Desarrollo Psicomotor: $psicomotor'),
                pw.Text('Desarrollo del Lenguaje: $lenguaje'),
                pw.Text('Control Esfintario: $esfintario'),
                pw.Text('Enfermedades Padecidas: $enfermedades'),
                pw.Text('Antecedentes Familiares: $familiares'),
                pw.SizedBox(height: 16),

                // Questionnaire Results
                pw.Text(
                  'Resultados del Cuestionario:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text('Puntuación: $score'),
                pw.Text('Resultado: $riskLevel'),
                pw.SizedBox(height: 16),

                // Conclusion
                pw.Text(
                  'Conclusión:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  riskLevel == 'BAJO'
                      ? 'Presencia de Riesgo de TEA BAJO. Ninguna otra medida necesaria a menos que la vigilancia del desarrollo indique riesgo de TEA.'
                      : riskLevel == 'MEDIO'
                      ? 'Presencia de Riesgo de TEA MODERADO. Remita al niño para una evaluación diagnóstica.'
                      : 'Presencia de Riesgo de TEA ALTO. Remita el caso de inmediato para evaluación diagnóstica.',
                ),
                pw.SizedBox(height: 16),

                // Footer
                pw.Text(
                  'Evaluador: ____________________________',
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Sello: ________________________________',
                  style: pw.TextStyle(fontSize: 14),
                ),
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
