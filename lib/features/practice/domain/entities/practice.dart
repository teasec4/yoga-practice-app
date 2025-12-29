enum DifficultyLevel { beginner, intermediate, advanced }

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
  final String description;
  final String fullDescription;
  final int durationMinutes;
  final DifficultyLevel difficulty;
  final int completedCount;
  final IconType iconType;
  final List<Movement> movements;

  const Practice({
    required this.id,
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.durationMinutes,
    required this.difficulty,
    required this.completedCount,
    required this.iconType,
    required this.movements,
  });

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
