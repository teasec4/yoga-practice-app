import 'package:flutter/material.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

/// Extensions для enum DifficultyLevel
extension DifficultyLevelExtension on DifficultyLevel {
  /// Возвращает цвет сложности
  Color get color {
    switch (this) {
      case DifficultyLevel.beginner:
        return const Color(0xFF8BC98D); // Green
      case DifficultyLevel.intermediate:
        return const Color(0xFFE8A655); // Orange
      case DifficultyLevel.advanced:
        return const Color(0xFFD4727A); // Red
    }
  }

  /// Возвращает текстовый лейбл сложности
  String get label {
    switch (this) {
      case DifficultyLevel.beginner:
        return 'Beginner';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
    }
  }
}
