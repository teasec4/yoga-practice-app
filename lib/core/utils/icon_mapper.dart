import 'package:flutter/material.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

/// Маппер для преобразования IconType в IconData
/// Избегает дублирования логики в разных частях приложения
class IconMapper {
  /// Преобразует [IconType] в [IconData]
  static IconData getIconData(IconType type) {
    switch (type) {
      case IconType.lotus:
        return Icons.self_improvement;
      case IconType.tree:
        return Icons.nature;
      case IconType.warrior:
        return Icons.sports_martial_arts;
      case IconType.downward:
        return Icons.trending_down;
      case IconType.meditation:
        return Icons.spa;
      case IconType.breathing:
        return Icons.air;
      case IconType.flexibility:
        return Icons.accessibility;
      case IconType.strength:
        return Icons.fitness_center;
      case IconType.balance:
        return Icons.hub;
      case IconType.relaxation:
        return Icons.cloud;
    }
  }
}
