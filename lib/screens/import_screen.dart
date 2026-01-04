import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/bowling_throw.dart';
import '../services/throw_service.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Import Video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ActionCard(
              icon: Icons.video_library,
              title: 'Load Video',
              subtitle: 'Select a video from your device',
              onTap: () => _pickVideo(context),
            ),
            const SizedBox(height: 16),
            _ActionCard(
              icon: Icons.analytics,
              title: 'Run Analysis',
              subtitle: 'Analyze imported throw',
              onTap: () => Navigator.pushNamed(context, '/analysis'),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => _showDebugDialog(context),
              child: const Text('DEBUG: Add Test Throw'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickVideo(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result == null) return;

    if (kIsWeb) {
      debugPrint('Picked video (web): ${result.files.single.name}');
    } else {
      final path = result.files.single.path!;
      final file = File(path);
      debugPrint('Picked video path: $path');
      debugPrint('File size: ${await file.length()} bytes');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video selected successfully')),
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
      builder: (_) => AlertDialog(
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
                breackpointBoard:
                    _parseNullable(breakpointBoardCtrl.text),
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  double? _parseNullable(String value) {
    if (value.trim().isEmpty) return null;
    return double.tryParse(value);
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 12 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, size: 32, color: AppColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 4),
                      Text(subtitle, style: AppTextStyles.bodyMuted),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
