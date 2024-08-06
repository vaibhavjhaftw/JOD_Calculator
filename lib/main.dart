import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_provider.dart';
import 'calculator_screen.dart';

void main() {
  runApp(JODCalculatorApp());
}

class JODCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: MaterialApp(
        title: 'JOD Calculator',
        theme: ThemeData(
          primaryColor: Colors.black,
          hintColor: Colors.orange,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
        ),
        home: CalculatorScreen(),
      ),
    );
  }
}
