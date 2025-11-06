import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analyzing Throw')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            const Text('Processing video...'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/results'),
              child: const Text('View Results'),
            ),
          ],
        ),
      ),
    );
  }
}
