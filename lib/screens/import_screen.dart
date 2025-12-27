import 'package:flutter/material.dart';
import '../models/bowling_throw.dart';
import '../services/throw_service.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import Video')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/analysis'),
              child: const Text('Run Analysis'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => _showDebugDialog(context),
              child: const Text('DEBUG: Add Test Throw'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDebugDialog(BuildContext context) {
    final launchAngleCtrl = TextEditingController();
    final impactAngleCtrl = TextEditingController();
    final launchSpeedCtrl = TextEditingController();
    final impactSpeedCtrl = TextEditingController();
    final foulLineCtrl = TextEditingController();
    final arrowsCtrl = TextEditingController();
    final entryBoardCtrl = TextEditingController();
    final breakpointBoardCtrl = TextEditingController();
    final breakpointDistanceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Debug Throw Input'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _numberField('Launch Angle (°)', launchAngleCtrl),
              _numberField('Impact Angle (°)', impactAngleCtrl),
              _numberField('Launch Speed (m/s)', launchSpeedCtrl),
              _numberField('Impact Speed (m/s)', impactSpeedCtrl),
              const Divider(),
              _numberField('Foul Line (board)', foulLineCtrl),
              _numberField('Arrows (board)', arrowsCtrl),
              _numberField('Entry Board', entryBoardCtrl),
              _numberField('Breakpoint Board', breakpointBoardCtrl),
              _numberField('Breakpoint Distance', breakpointDistanceCtrl),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final throwData = BowlingThrow(
                id: '',
                launchAngle: double.parse(launchAngleCtrl.text),
                impactAngle: double.parse(impactAngleCtrl.text),
                launchSpeed: double.parse(launchSpeedCtrl.text),
                impactSpeed: double.parse(impactSpeedCtrl.text),
                foulLine: _parseNullable(foulLineCtrl.text),
                arrows: _parseNullable(arrowsCtrl.text),
                entryBoard: _parseNullable(entryBoardCtrl.text),
                breackpointBoard: _parseNullable(breakpointBoardCtrl.text),
                breackpointDistance:
                    _parseNullable(breakpointDistanceCtrl.text),
                createdAt: DateTime.now(),
              );

              await ThrowService.saveThrow(throwData);

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test throw saved')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _numberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  double? _parseNullable(String value) {
    if (value.trim().isEmpty) return null;
    return double.tryParse(value);
  }
}
