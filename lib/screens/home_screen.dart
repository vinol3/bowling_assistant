import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bowling Assistant'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ActionCard(
              icon: Icons.auto_stories_outlined,
              title: 'Recorded Throws',
              subtitle: 'See all recorded throws',
              onTap: () => Navigator.pushNamed(context, '/analysis'),
            ),
            const SizedBox(height: 16),
            _ActionCard(
              icon: Icons.videocam,
              title: 'Record Video',
              subtitle: 'Capture a new attempt',
              onTap: () => Navigator.pushNamed(context, '/record'),
            ),
            const SizedBox(height: 16),
            _ActionCard(
              icon: Icons.upload,
              title: 'Import Video',
              subtitle: 'Analyze existing footage',
              onTap: () => Navigator.pushNamed(context, '/import'),
            ),
             const SizedBox(height: 16),
            _ActionCard(
              icon: Icons.analytics_outlined,
              title: 'Stats',
              subtitle: 'Aggregated throw statistics',
              onTap: () => Navigator.pushNamed(context, '/results'),
            ),
            const SizedBox(height: 16),
            _ActionCard(
              icon: Icons.settings,
              title: 'Settings',
              subtitle: 'App preferences',
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
      ),
    );
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
