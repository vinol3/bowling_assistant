import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bowling_assistant/screens/home_screen.dart';
import 'package:bowling_assistant/auth/auth_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Not logged in
        if (!snapshot.hasData) {
          return const AuthScreen();
        }

        // Logged in
        return HomeScreen();
      },
    );
  }
}
