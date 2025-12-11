import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    try {
      setState(() => isLoading = true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      showMessage(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> signUp() async {
    try {
      setState(() => isLoading = true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      showMessage(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "Login or create an account",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 40),

                // Email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),

                // Buttons
                isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          // LOGIN
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: login,
                              child: const Text("Log In"),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // SIGN UP
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: signUp,
                              child: const Text("Sign Up"),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
