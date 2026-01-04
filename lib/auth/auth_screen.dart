import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _login() async {
    try {
      setState(() => isLoading = true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      _showMessage(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _signUp() async {
    try {
      setState(() => isLoading = true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      _showMessage(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        final animation = ModalRoute.of(dialogContext)!.animation!;

        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Authentication Error'),
            content: Text(
              _humanizeFirebaseError(message),
              style: AppTextStyles.body,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }


  String _humanizeFirebaseError(String error) {
    if (error.contains('user-not-found')) {
      return 'No account found for this email.';
    }
    if (error.contains('wrong-password')) {
      return 'Incorrect password.';
    }
    if (error.contains('invalid-email')) {
      return 'Please enter a valid email address.';
    }
    if (error.contains('email-already-in-use')) {
      return 'An account with this email already exists.';
    }
    if (error.contains('weak-password')) {
      return 'Password should be at least 6 characters.';
    }

    return 'Authentication failed. Please try again.';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 400),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_graph_rounded,
                        size: 64,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Bowling Assistant',
                        style: AppTextStyles.headline,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Log in or create an account',
                        style: AppTextStyles.bodyMuted,
                      ),
                      const SizedBox(height: 32),

                      _InputField(
                        controller: emailController,
                        label: 'Email',
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        controller: passwordController,
                        label: 'Password',
                        obscure: true,
                      ),
                      const SizedBox(height: 24),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: FilledButton(
                                      onPressed: _login,
                                      child: const Text('Log In'),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: _signUp,
                                      child: const Text('Sign Up'),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;

  const _InputField({
    required this.controller,
    required this.label,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
