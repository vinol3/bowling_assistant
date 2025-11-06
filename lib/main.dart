import 'package:bowling_assistant/screens/calibration_screen.dart';
import 'package:bowling_assistant/screens/home_screen.dart';
import 'package:bowling_assistant/screens/record_screen.dart';
import 'package:flutter/material.dart';
import 'package:bowling_assistant/screens/import_screen.dart';
import 'package:bowling_assistant/screens/analysis_screen.dart';
import 'package:bowling_assistant/screens/result_screen.dart';
import 'package:bowling_assistant/screens/compare_screen.dart';
import 'package:bowling_assistant/screens/settings_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bowling Stats',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/calibration': (context) => CalibrationScreen(),
        '/record': (context) => RecordScreen(),
        '/import': (context) => ImportScreen(),
        '/analysis': (context) => AnalysisScreen(),
        '/results': (context) => ResultsScreen(),
        '/compare': (context) => CompareScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}