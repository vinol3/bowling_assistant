import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // ===== Headlines =====

  static const headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.2,
  );

  static const sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // ===== Body text =====

  static const body = TextStyle(
    fontSize: 16,
    height: 1.4,
  );

  static const bodyMuted = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  // ===== Labels & values (stats) =====

  static const statLabel = TextStyle(
    fontSize: 13,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );

  static const statValue = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // ===== Buttons =====

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // ===== Small / helper =====

  static const caption = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );
}
