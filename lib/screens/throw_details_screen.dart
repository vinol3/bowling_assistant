import 'package:flutter/material.dart';
import '../models/bowling_throw.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class ThrowDetailScreen extends StatelessWidget {
  final BowlingThrow throwData;

  const ThrowDetailScreen({
    super.key,
    required this.throwData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Throw Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _AnimatedSection(
            title: 'General',
            children: [
              _RowItem(
                label: 'Date & Time',
                value: throwData.createdAt != null
                    ? _formatFullDateTime(throwData.createdAt!)
                    : '--',
              ),
            ],
          ),
          _AnimatedSection(
            title: 'Speed',
            children: [
              _RowItem(
                label: 'Launch Speed',
                value:
                    '${throwData.launchSpeed.toStringAsFixed(2)} m/s',
              ),
              _RowItem(
                label: 'Impact Speed',
                value:
                    '${throwData.impactSpeed.toStringAsFixed(2)} m/s',
              ),
            ],
          ),
          _AnimatedSection(
            title: 'Angles',
            children: [
              _RowItem(
                label: 'Launch Angle',
                value:
                    '${throwData.launchAngle.toStringAsFixed(2)}°',
              ),
              _RowItem(
                label: 'Impact Angle',
                value:
                    '${throwData.impactAngle.toStringAsFixed(2)}°',
              ),
            ],
          ),
          _AnimatedSection(
            title: 'Lane Path',
            children: [
              _RowItem(
                label: 'Foul Line',
                value: _formatNullable(throwData.foulLine),
              ),
              _RowItem(
                label: 'Arrows',
                value: _formatNullable(throwData.arrows),
              ),
              _RowItem(
                label: 'Entry Board',
                value: _formatNullable(throwData.entryBoard),
              ),
              _RowItem(
                label: 'Breakpoint Board',
                value:
                    _formatNullable(throwData.breackpointBoard),
              ),
              _RowItem(
                label: 'Breakpoint Distance',
                value:
                    _formatNullable(throwData.breackpointDistance),
              ),
            ],
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

class _AnimatedSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _AnimatedSection({
    required this.title,
    required this.children,
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
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.sectionTitle),
              const SizedBox(height: 12),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String label;
  final String value;

  const _RowItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.statLabel,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.statValue.copyWith(
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
