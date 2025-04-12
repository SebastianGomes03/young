import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:young/utils/routes.dart';
import '../widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo on the top left
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/Logo.png', // Replace with your logo asset path
                height: 130,
              ),
            ),
            const Spacer(),
            // Center content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Welcome text
                const Text(
                  'Bienvenido, escoja la opción a realizar:',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Buttons
                Button(
                  type: 'menu',
                  label: 'Cuestionario M-CHAT',
                  color: 'primary', // Primary color
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.mchatregister,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Button(
                  type: 'menu',
                  label: 'Haizea-Llevant',
                  color: 'primary', // Primary color
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.mchatregister,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Button(
                  type: 'menu',
                  label: 'Salir',
                  color: 'primary', // Primary color
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
