import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

// Export Movement for convenience
export 'package:yoga_coach/features/practice/domain/entities/practice.dart'
    show Movement;

/// Standard app content: practices and movements
/// Edit this file to change default practices and available poses for custom practice creation

// ============================================================================
// AVAILABLE MOVEMENTS (All poses that can be selected for custom practices)
// Organized by practice ID for easy navigation
// ============================================================================

final availableMovements = [
  // Lotus Flow movements (1-x)
  Movement(
    id: '1-1',
    name: 'Seated Child\'s Pose',
    description: 'Rest and breathe deeply',
    durationSeconds: 30,
  ),
  Movement(
    id: '1-2',
    name: 'Cat-Cow Stretch',
    description: 'Warm up your spine',
    durationSeconds: 45,
  ),
  Movement(
    id: '1-3',
    name: 'Downward Dog',
    description: 'Full body stretch',
    durationSeconds: 60,
  ),
  Movement(
    id: '1-4',
    name: 'Mountain Pose',
    description: 'Find your foundation',
    durationSeconds: 30,
  ),
  Movement(
    id: '1-5',
    name: 'Standing Forward Fold',
    description: 'Hamstring stretch',
    durationSeconds: 45,
  ),
  Movement(
    id: '1-6',
    name: 'Gentle Twist',
    description: 'Massage your organs',
    durationSeconds: 30,
  ),
  Movement(
    id: '1-7',
    name: 'Lotus Pose',
    description: 'Deep hip opener',
    durationSeconds: 60,
  ),
  Movement(
    id: '1-8',
    name: 'Savasana',
    description: 'Final relaxation',
    durationSeconds: 120,
  ),

  // Tree Pose Balance movements (2-x)
  Movement(
    id: '2-1',
    name: 'Mountain Pose',
    description: 'Ground yourself',
    durationSeconds: 30,
  ),
  Movement(
    id: '2-2',
    name: 'Half Moon Pose',
    description: 'Side body stretch',
    durationSeconds: 45,
  ),
  Movement(
    id: '2-3',
    name: 'Tree Pose Right',
    description: 'Balance on right leg',
    durationSeconds: 60,
  ),
  Movement(
    id: '2-4',
    name: 'Tree Pose Left',
    description: 'Balance on left leg',
    durationSeconds: 60,
  ),
  Movement(
    id: '2-5',
    name: 'Eagle Pose',
    description: 'Enhance stability',
    durationSeconds: 45,
  ),
  Movement(
    id: '2-6',
    name: 'Warrior III',
    description: 'Advanced balance',
    durationSeconds: 45,
  ),

  // Warrior Strength movements (3-x)
  Movement(
    id: '3-1',
    name: 'Warrior I',
    description: 'Strength and stability',
    durationSeconds: 60,
  ),
  Movement(
    id: '3-2',
    name: 'Warrior II',
    description: 'Power and focus',
    durationSeconds: 60,
  ),
  Movement(
    id: '3-3',
    name: 'Reverse Warrior',
    description: 'Side body extension',
    durationSeconds: 45,
  ),
  Movement(
    id: '3-4',
    name: 'Warrior III',
    description: 'Balance and strength',
    durationSeconds: 60,
  ),
  Movement(
    id: '3-5',
    name: 'Crescent Lunge',
    description: 'Hip flexor stretch',
    durationSeconds: 45,
  ),
  Movement(
    id: '3-6',
    name: 'Chair Pose',
    description: 'Quad strengthening',
    durationSeconds: 45,
  ),
  Movement(
    id: '3-7',
    name: 'Goddess Pose',
    description: 'Leg endurance',
    durationSeconds: 60,
  ),
  Movement(
    id: '3-8',
    name: 'Plank Pose',
    description: 'Core engagement',
    durationSeconds: 60,
  ),
  Movement(
    id: '3-9',
    name: 'Downward Dog',
    description: 'Full body stretch',
    durationSeconds: 45,
  ),
  Movement(
    id: '3-10',
    name: 'Chaturanga',
    description: 'Arm strength',
    durationSeconds: 30,
  ),
  Movement(
    id: '3-11',
    name: 'Upward Dog',
    description: 'Chest opener',
    durationSeconds: 30,
  ),
  Movement(
    id: '3-12',
    name: 'Savasana',
    description: 'Final relaxation',
    durationSeconds: 120,
  ),
];

// ============================================================================
// STANDARD PRACTICES (3 main practices displayed on Practice screen)
// ============================================================================

final standardPractices = [
  Practice(
    id: '1',
    title: 'Lotus Flow',
    description: 'Gentle opening sequence',
    fullDescription:
        'Start your yoga journey with this gentle opening sequence. Perfect for beginners, this lesson combines breath work with flowing movements to warm up your body and prepare for deeper poses.',
    difficulty: DifficultyLevel.beginner,
    iconType: IconType.lotus,
    movements: availableMovements.where((m) => m.id.startsWith('1-')).toList(),
    createdAt: DateTime.now(),
    isCustom: false,
  ),
  Practice(
    id: '2',
    title: 'Tree Pose Balance',
    description: 'Improve stability and focus',
    fullDescription:
        'Develop your sense of balance and improve focus with this tree pose focused practice. This lesson emphasizes grounding and mental clarity through standing balance poses.',
    difficulty: DifficultyLevel.beginner,
    iconType: IconType.tree,
    movements: availableMovements.where((m) => m.id.startsWith('2-')).toList(),
    createdAt: DateTime.now(),
    isCustom: false,
  ),
  Practice(
    id: '3',
    title: 'Warrior Strength',
    description: 'Build power and endurance',
    fullDescription:
        'Build strength and confidence with warrior poses. This dynamic practice targets your legs, core, and upper body while building mental resilience and determination.',
    difficulty: DifficultyLevel.intermediate,
    iconType: IconType.warrior,
    movements: availableMovements.where((m) => m.id.startsWith('3-')).toList(),
    createdAt: DateTime.now(),
    isCustom: false,
  ),
];
