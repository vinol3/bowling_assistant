import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bowling Stats')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/calibration'),
                child: const Text('Calibrate Lane')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/record'),
                child: const Text('Record New Throw')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/import'),
                child: const Text('Load Existing Video')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                child: const Text('Settings')),
          ],
        ),
      ),
    );
  }
}
