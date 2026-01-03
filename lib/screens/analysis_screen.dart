import 'package:flutter/material.dart';
import '../models/bowling_throw.dart';
import '../services/throw_service.dart';
import '../screens/throw_details_screen.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Throw Analysis'),
      ),
      body: StreamBuilder<List<BowlingThrow>>(
        stream: ThrowService.throwsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _EmptyState();
          }

          final throws = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: throws.length,
            itemBuilder: (context, index) {
              final t = throws[index];

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Duration(milliseconds: 250 + index * 40),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 16 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: _ThrowCard(
                  throwData: t,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, animation, __) => FadeTransition(
                          opacity: animation,
                          child: ThrowDetailScreen(throwData: t),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ThrowCard extends StatelessWidget {
  final BowlingThrow throwData;
  final VoidCallback onTap;

  const _ThrowCard({
    required this.throwData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.sports_golf,
                size: 28,
                color: AppColors.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatFullDateTime(throwData.createdAt),
                      style: AppTextStyles.caption,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _Stat(
                          label: 'Launch',
                          value:
                              '${throwData.launchSpeed.toStringAsFixed(1)} m/s',
                        ),
                        const SizedBox(width: 16),
                        _Stat(
                          label: 'Impact',
                          value:
                              '${throwData.impactSpeed.toStringAsFixed(1)} m/s',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;

  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.statLabel),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.statValue),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: 1,
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.insights, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text('No throws yet', style: AppTextStyles.headline),
            SizedBox(height: 6),
            Text(
              'Record or import a throw to begin',
              style: AppTextStyles.bodyMuted,
            ),
          ],
        ),
      ),
    );
  }
}

String _formatFullDateTime(DateTime dt) {
  return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
      '${dt.day.toString().padLeft(2, '0')} '
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}:'
      '${dt.second.toString().padLeft(2, '0')}';
}
