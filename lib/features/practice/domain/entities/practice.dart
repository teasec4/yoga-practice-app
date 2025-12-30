enum DifficultyLevel { beginner, intermediate, advanced }

enum DurationMultiplier {
  x1(1), // Standard
  x2(2), // Double
  x3(3); // Triple

  final int value;
  const DurationMultiplier(this.value);

  String get label => 'x$value';
}

class Movement {
  final String id;
  final String name;
  final String description;
  final int durationSeconds;

  const Movement({
    required this.id,
    required this.name,
    required this.description,
    required this.durationSeconds,
  });
}

class Practice {
  final String id;
  final String title;
  final String? description;
  final String? fullDescription;
  final DifficultyLevel difficulty;
  final IconType? iconType;
  final List<Movement> movements;
  final DateTime createdAt;
  final DurationMultiplier durationMultiplier;
  final bool isCustom;

  Practice({
    required this.id,
    required this.title,
    this.description,
    this.fullDescription,
    required this.difficulty,
    this.iconType,
    required this.movements,
    required this.createdAt,
    this.durationMultiplier = DurationMultiplier.x1,
    required this.isCustom,
  });

  int get durationSeconds {
    final baseDuration = movements.fold(
      0,
      (sum, movement) => sum + movement.durationSeconds,
    );
    return baseDuration * durationMultiplier.value;
  }

  int get durationMinutes => (durationSeconds / 60).ceil();

  int get poseCount => movements.length;
}

enum IconType {
  lotus,
  tree,
  warrior,
  downward,
  meditation,
  breathing,
  flexibility,
  strength,
  balance,
  relaxation,
}