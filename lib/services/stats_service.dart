import '../models/bowling_throw.dart';
import '../models/throw_stats.dart';

class StatsService {
  static ThrowStats calculate(List<BowlingThrow> throws) {
    if (throws.isEmpty) {
      return ThrowStats(
        totalThrows: 0,
        avgLaunchSpeed: 0,
        avgImpactSpeed: 0,
      );
    }

    final total = throws.length;

    final avgImpactSpeed =
        throws.map((t) => t.impactSpeed).reduce((a, b) => a + b) / total;

    final avgLaunchSpeed =
        throws.map((t) => t.launchSpeed).reduce((a, b) => a + b) / total;

    return ThrowStats(
      totalThrows: total,
      avgLaunchSpeed: avgLaunchSpeed,
      avgImpactSpeed: avgImpactSpeed,
    );
  }
}
