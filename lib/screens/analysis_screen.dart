import 'package:bowling_assistant/screens/throw_details_screen.dart';
import 'package:flutter/material.dart';
import '../models/bowling_throw.dart';
import '../services/throw_service.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Throw Analysis')),
      body: StreamBuilder<List<BowlingThrow>>(
        stream: ThrowService.throwsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No throws recorded yet'));
          }

          final throws = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: throws.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final t = throws[index];

              return ListTile(
                leading: const Icon(Icons.sports_baseball),
                title: Text(
                  'Launch: ${t.launchSpeed.toStringAsFixed(1)} m/s • '
                  'Impact: ${t.impactSpeed.toStringAsFixed(1)} m/s',
                ),
                subtitle: Text(_formatFullDateTime(t.createdAt)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ThrowDetailScreen(throwData: t),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatFullDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
           '${dt.day.toString().padLeft(2, '0')} '
           '${dt.hour.toString().padLeft(2, '0')}:'
           '${dt.minute.toString().padLeft(2, '0')}:'
           '${dt.second.toString().padLeft(2, '0')}';
  }
}
