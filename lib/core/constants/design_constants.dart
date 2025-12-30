/// Константы дизайна приложения
/// Используются для консистентности и легкого изменения размеров/отступов
class DesignConstants {
  // Запретить инстанцирование
  DesignConstants._();

  // ======================== ICON SIZES ========================
  /// Маленькие иконки (16px)
  static const double iconXSmall = 16;

  /// Маленькие иконки (20px)
  static const double iconSmall = 20;

  /// Средние иконки (24px)
  static const double iconMedium = 24;

  /// Большие иконки (32px)
  static const double iconLarge = 32;

  /// Очень большие иконки (48px)
  static const double iconXLarge = 48;

  /// Гигантские иконки (80px)
  static const double iconHuge = 80;

  // ======================== SPACING ========================
  /// Мини отступ (4px)
  static const double spacingXSmall = 4;

  /// Маленький отступ (8px)
  static const double spacingSmall = 8;

  /// Средний отступ (12px)
  static const double spacingMedium = 12;

  /// Большой отступ (16px)
  static const double spacingLarge = 16;

  /// Очень большой отступ (24px)
  static const double spacingXLarge = 24;

  /// Гигантский отступ (32px)
  static const double spacingHuge = 32;

  // ======================== BORDER RADIUS ========================
  /// Маленький радиус (6px)
  static const double radiusSmall = 6;

  /// Средний радиус (8px)
  static const double radiusMedium = 8;

  /// Большой радиус (12px)
  static const double radiusLarge = 12;

  /// Очень большой радиус (16px)
  static const double radiusXLarge = 16;

  /// Максимальный радиус (24px)
  static const double radiusHuge = 24;

  // ======================== SIZES ========================
  /// Маленький размер компонента (40x40)
  static const double sizeSmall = 40;

  /// Средний размер компонента (48x48)
  static const double sizeMedium = 48;

  /// Большой размер компонента (60x60)
  static const double sizeLarge = 60;

  /// Очень большой размер компонента (80x80)
  static const double sizeXLarge = 80;

  // ======================== BUTTON HEIGHTS ========================
  /// Минимальная высота кнопки
  static const double buttonHeightSmall = 40;

  /// Стандартная высота кнопки
  static const double buttonHeightMedium = 48;

  /// Большая высота кнопки
  static const double buttonHeightLarge = 56;

  // ======================== SHADOWS ========================
  /// Маленькая тень (blur 4)
  static const double shadowBlurSmall = 4;

  /// Средняя тень (blur 8)
  static const double shadowBlurMedium = 8;

  /// Большая тень (blur 16)
  static const double shadowBlurLarge = 16;

  // ======================== OPACITY ========================
  /// Легкая прозрачность
  static const double opacityLight = 0.05;

  /// Средняя прозрачность
  static const double opacityMedium = 0.1;

  /// Полупрозрачность
  static const double opacityHalf = 0.5;

  // ======================== DURATIONS ========================
  /// Быстрая анимация (200ms)
  static const Duration durationFast = Duration(milliseconds: 200);

  /// Стандартная анимация (300ms)
  static const Duration durationMedium = Duration(milliseconds: 300);

  /// Медленная анимация (500ms)
  static const Duration durationSlow = Duration(milliseconds: 500);

  // ======================== MAX WIDTHS ========================
  /// Максимальная ширина для контента на большом экране
  static const double maxContentWidth = 600;

  /// Ширина tile для practice list
  static const double practiceCardWidth = 0.75; // 75% от экрана

  /// Максимальная высота для practice card
  static const double practiceCardMaxHeight = 400;
}
