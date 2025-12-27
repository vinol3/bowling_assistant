class BowlingThrow {
  final String id;
  final double launchAngle;
  final double impactAngle;
  final double launchSpeed;
  final double impactSpeed;
  final double? foulLine;
  final double? arrows;
  final double? entryBoard;
  final double? breackpointBoard;
  final double? breackpointDistance;
  final DateTime createdAt;

  BowlingThrow({
    required this.id,
    required this.launchAngle,
    required this.impactAngle,
    required this.launchSpeed,
    required this.impactSpeed,
    required this.foulLine,
    required this.arrows,
    required this.entryBoard,
    required this.breackpointBoard,
    required this.breackpointDistance,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'launchAngle': launchAngle,
      'impactAngle': impactAngle,
      'launchSpeed': launchSpeed,
      'impactSpeed': impactSpeed,
      'foulLine': foulLine,
      'arrows': arrows,
      'entryBoard': entryBoard,
      'breackpointBoard': breackpointBoard,
      'breackpointDistance': breackpointDistance,
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
      foulLine: map['foulLine'] != null ? (map['foulLine'] as num).toDouble() : null,
      arrows: map['arrows'] != null ? (map['arrows'] as num).toDouble() : null,
      entryBoard: map['entryBoard'] != null ? (map['entryBoard'] as num).toDouble() : null,
      breackpointBoard: map['breackpointBoard'] != null ? (map['breackpointBoard'] as num).toDouble() : null,
      breackpointDistance: map['breackpointDistance'] != null ? (map['breackpointDistance'] as num).toDouble() : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
