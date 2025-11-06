import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Results Placeholder'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/compare'),
              child: const Text('Compare Throws'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
