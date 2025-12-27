import 'package:flutter/material.dart';
import '../models/bowling_throw.dart';

class ThrowDetailScreen extends StatelessWidget {
  final BowlingThrow throwData;

  const ThrowDetailScreen({
    super.key,
    required this.throwData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Throw Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('General'),
          _row('Date & Time', _formatFullDateTime(throwData.createdAt)),

          const SizedBox(height: 16),
          _sectionTitle('Speed'),
          _row('Launch Speed', '${throwData.launchSpeed.toStringAsFixed(2)} m/s'),
          _row('Impact Speed', '${throwData.impactSpeed.toStringAsFixed(2)} m/s'),

          const SizedBox(height: 16),
          _sectionTitle('Angles'),
          _row('Launch Angle', '${throwData.launchAngle.toStringAsFixed(2)}°'),
          _row('Impact Angle', '${throwData.impactAngle.toStringAsFixed(2)}°'),

          const SizedBox(height: 16),
          _sectionTitle('Lane Path'),
          _row('Foul Line', _formatNullable(throwData.foulLine)),
          _row('Arrows', _formatNullable(throwData.arrows)),
          _row('Entry Board', _formatNullable(throwData.entryBoard)),
          _row('Breakpoint Board', _formatNullable(throwData.breackpointBoard)),
          _row(
            'Breakpoint Distance',
            _formatNullable(throwData.breackpointDistance),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _formatNullable(double? value) {
    return value == null ? '—' : value.toStringAsFixed(2);
  }

  String _formatFullDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
           '${dt.day.toString().padLeft(2, '0')} '
           '${dt.hour.toString().padLeft(2, '0')}:'
           '${dt.minute.toString().padLeft(2, '0')}:'
           '${dt.second.toString().padLeft(2, '0')}';
  }
}
