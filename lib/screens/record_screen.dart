import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Throw')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Camera preview placeholder'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/analysis'),
              child: const Text('Analyze Throw'),
            ),
          ],
        ),
      ),
    );
  }
}
