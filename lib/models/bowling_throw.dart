class BowlingThrow {
  final String id;
  final double launchAngle;
  final double impactAngle;
  final double launchSpeed;
  final double impactSpeed;
  final DateTime createdAt;

  BowlingThrow({
    required this.id,
    required this.launchAngle,
    required this.impactAngle,
    required this.launchSpeed,
    required this.impactSpeed,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'launchAngle': launchAngle,
      'impactAngle': impactAngle,
      'launchSpeed': launchSpeed,
      'impactSpeed': impactSpeed,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BowlingThrow.fromMap(String id, Map<String, dynamic> map) {
    return BowlingThrow(
      id: id,
      launchAngle: (map['launchAngle'] as num).toDouble(),
      impactAngle: (map['impactAngle'] as num).toDouble(),
      launchSpeed: (map['launchSpeed'] as num).toDouble(),
      impactSpeed: (map['impactSpeed'] as num).toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
