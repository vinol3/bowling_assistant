import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';

import 'firebase_options.dart';
import 'auth/auth_gate.dart';

import 'theme/app_theme.dart';

import 'screens/calibration_screen.dart';
import 'screens/record_screen.dart';
import 'screens/import_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/result_screen.dart';
import 'screens/compare_screen.dart';
import 'screens/settings_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    cameras = await availableCameras();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bowling Assistant',
      theme: AppTheme.darkTheme,
      home: const AuthGate(),
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case '/calibration':
            page = const CalibrationScreen();
            break;
          case '/record':
            page = const RecordScreen();
            break;
          case '/import':
            page = const ImportScreen();
            break;
          case '/analysis':
            page = const AnalysisScreen();
            break;
          case '/results':
            page = const ResultsScreen();
            break;
          case '/compare':
            page = const CompareScreen();
            break;
          case '/settings':
            page = const SettingsScreen();
            break;
          default:
            page = const AuthGate();
        }

        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (_, animation, __) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(animation),
              child: page,
            ),
          ),
        );
      },
    );
  }
}
