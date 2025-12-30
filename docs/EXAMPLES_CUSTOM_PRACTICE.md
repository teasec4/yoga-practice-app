# Custom Practice Examples & Code Snippets

**Last Updated**: Dec 30, 2025

---

## Table of Contents

1. [User Interface Examples](#user-interface-examples)
2. [Code Examples](#code-examples)
3. [Data Flow Examples](#data-flow-examples)
4. [Testing Examples](#testing-examples)
5. [Navigation Examples](#navigation-examples)

---

## User Interface Examples

### Example 1: Creating "Morning Stretch" Practice

**Step 1: Tap FAB**
```
Practice Tab
├─ All default practices
├─ Custom practices (empty)
└─ FAB: "+" button (bottom-right)
     ↓ TAP
```

**Step 2: Name Entry**
```
Create Custom Practice Dialog
┌─────────────────────────────────┐
│ Create Custom Practice        ✕ │
├─────────────────────────────────┤
│ ┌─ Practice Name...          ─┐ │
│ │ Morning Stretch            │ │
│ └────────────────────────────┘ │
│                                 │
│ Selected: 0 | Total: 0 min      │
└─────────────────────────────────┘
```

**Step 3: Select Poses**
```
Available Poses:

Lotus Flow (section)
┌──────────────────────────────┐
│ ⊕ Child's Pose        60 sec │ ☐
└──────────────────────────────┘
   ↓ TAP (becomes selected)
┌──────────────────────────────┐
│ ① Child's Pose        60 sec │ ✓
└──────────────────────────────┘

┌──────────────────────────────┐
│ ⊕ Cat-Cow Stretch     45 sec │ ☐
└──────────────────────────────┘
   ↓ TAP
┌──────────────────────────────┐
│ ② Cat-Cow Stretch     45 sec │ ✓
└──────────────────────────────┘

... continue selecting ...

Selected: 3 | Total: 2.5 min
```

**Step 4: Review & Create**
```
Poses in Order:
┌─────────────────────────────┐
│ ① Child's Pose        60s   │
│ ② Cat-Cow Stretch     45s   │
│ ③ Mountain Pose       60s   │
└─────────────────────────────┘

[Create Practice] button
```

**Step 5: Success**
```
✓ SnackBar: "Tренировка "Morning Stretch" создана"

Practice Tab now shows:
├─ CUSTOM PRACTICES
│  └─ Morning Stretch (3 poses • 2.5 min) [✎]
│
└─ DEFAULT PRACTICES
   └─ (all 10 practices)
```

---

### Example 2: Viewing Custom Practice Details

**From List**
```
Practice Tab
├─ Morning Stretch (3 poses • 2.5 min) [✎]
  └─ TAP
```

**Detail Screen**
```
┌──────────────────────────────┐
│ Custom Practice          ✕   │
├──────────────────────────────┤
│                              │
│         [Custom icon]        │
│     Morning Stretch          │
│      [Custom badge]          │
│                              │
│ Duration: 2.5 min  Poses: 3  │
│                              │
│ Poses in Order:              │
│ ① Child's Pose               │
│    Rest and breathe deeply   │
│    60 sec                    │
│                              │
│ ② Cat-Cow Stretch            │
│    Warm up your spine        │
│    45 sec                    │
│                              │
│ ③ Mountain Pose              │
│    Find your foundation      │
│    60 sec                    │
│                              │
│ [Start Practice] button      │
└──────────────────────────────┘
```

---

## Code Examples

### Example 1: Create CustomPractice Programmatically

```dart
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

void createMorningRoutine() {
  final movements = [
    Movement(
      id: '1-1',
      name: 'Child\'s Pose',
      description: 'Rest and breathe deeply',
      durationSeconds: 60,
    ),
    Movement(
      id: '1-2',
      name: 'Cat-Cow Stretch',
      description: 'Warm up your spine',
      durationSeconds: 45,
    ),
    Movement(
      id: '2-3',
      name: 'Mountain Pose',
      description: 'Find your foundation',
      durationSeconds: 60,
    ),
  ];

  final customPractice = CustomPractice(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    title: 'Morning Stretch',
    movements: movements,
    createdAt: DateTime.now(),
  );

  print('Created: ${customPractice.title}');
  print('Poses: ${customPractice.poseCount}');
  print('Duration: ${customPractice.durationMinutes} minutes');
}

// Output:
// Created: Morning Stretch
// Poses: 3
// Duration: 2 minutes
```

### Example 2: Store & Retrieve

```dart
import 'package:yoga_coach/features/practice/data/models/custom_practice_storage.dart';

void storageExample() {
  final storage = CustomPracticeStorage();
  
  // Create a practice
  final practice = CustomPractice(
    id: 'custom-1',
    title: 'Evening Yoga',
    movements: [...],
    createdAt: DateTime.now(),
  );
  
  // Store it
  storage.addPractice(practice);
  
  // Retrieve it
  final retrieved = storage.getPractice('custom-1');
  
  if (retrieved != null) {
    print('Found: ${retrieved.title}');
    print('Total time: ${retrieved.durationMinutes} min');
  }
  
  // Get all practices
  final allPractices = storage.customPractices;
  print('Total custom practices: ${allPractices.length}');
  
  // Remove it
  storage.removePractice('custom-1');
}
```

### Example 3: Open Create Dialog

```dart
import 'package:flutter/material.dart';
import 'package:yoga_coach/features/practice/presentation/screens/create_custom_practice_screen.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final result = await showDialog(
          context: context,
          builder: (context) => const CreateCustomPracticeScreen(),
        );
        
        if (result != null) {
          // User created a practice
          print('Created: ${result.title}');
          
          // Show confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Created "${result.title}"'),
              duration: const Duration(seconds: 2),
            ),
          );
          
          // You could also navigate here
          // context.go('/practice/custom/${result.id}');
        } else {
          // User cancelled
          print('Cancelled');
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
```

### Example 4: Navigate to Custom Practice

```dart
import 'package:go_router/go_router.dart';

void navigateToCustomPractice(BuildContext context, String practiceId) {
  // Navigate to custom practice detail
  context.go('/practice/custom/$practiceId');
  
  // Or push (if you want back navigation)
  // context.push('/practice/custom/$practiceId');
}

// Usage:
// navigateToCustomPractice(context, 'custom-123');
```

### Example 5: Calculate Total Duration

```dart
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';

void durationExample(CustomPractice practice) {
  // Duration in seconds
  final seconds = practice.durationSeconds;
  print('Total seconds: $seconds');
  
  // Duration in minutes (rounded up)
  final minutes = practice.durationMinutes;
  print('Total minutes: $minutes');
  
  // Format nicely
  final formatted = '${practice.poseCount} poses, ${minutes} min';
  print('Display: $formatted');
}

// Example output:
// Total seconds: 240
// Total minutes: 4
// Display: 3 poses, 4 min
```

---

## Data Flow Examples

### Example 1: Complete User Creation Flow

```
┌──────────────────────────────────────────────────────┐
│ User Interaction Flow                                │
└──────────────────────────────────────────────────────┘

1. User taps FAB
   ↓
2. CreateCustomPracticeScreen dialog opens
   ├─ Empty state: name field + empty selection preview
   ↓
3. User enters name "Evening Relaxation"
   ├─ _nameController.text = "Evening Relaxation"
   ↓
4. User browses poses, selects:
   ├─ Tap: Reclined Pigeon (90s)
   │  └─ _selectedMovements = [ReclinedPigeon]
   │  └─ _selectedMovementIds = {"10-3"}
   │
   ├─ Tap: Happy Baby (60s)
   │  └─ _selectedMovements = [ReclinedPigeon, HappyBaby]
   │  └─ _selectedMovementIds = {"10-3", "10-4"}
   │
   └─ Tap: Savasana (300s)
      └─ _selectedMovements = [ReclinedPigeon, HappyBaby, Savasana]
      └─ _selectedMovementIds = {"10-3", "10-4", "10-7"}

5. Preview updates:
   ├─ Selected: 3 | Total: 7.5 min
   ├─ Poses in Order:
   │  ① Reclined Pigeon (90s)
   │  ② Happy Baby (60s)
   │  ③ Savasana (300s)

6. User taps Create Practice
   ├─ Validate name: ✅ "Evening Relaxation"
   ├─ Validate poses: ✅ 3 selected
   ↓
7. Create CustomPractice:
   ├─ id = DateTime.now().millisecondsSinceEpoch.toString()
   ├─ title = "Evening Relaxation"
   ├─ movements = [...] (ordered list)
   ├─ createdAt = DateTime.now()
   ↓
8. Store in CustomPracticeStorage:
   ├─ storage.addPractice(customPractice)
   ├─ _customPractices.add(customPractice)
   ↓
9. Dialog closes
   ├─ Returns customPractice
   ↓
10. PracticeScreen receives result
    ├─ setState(() { _storage.addPractice(result) })
    ├─ Shows SnackBar: "Тренировка "Evening Relaxation" создана"
    ↓
11. Practice appears in list
    ├─ Rebuilt ListView with custom practice at position 0
    └─ Custom practice tile shows: "Evening Relaxation | 3 poses • 7.5 min"
```

### Example 2: Storage Architecture

```
Memory Layout:
┌─────────────────────────────────────────┐
│ CustomPracticeStorage (Singleton)       │
├─────────────────────────────────────────┤
│ static _instance                        │
│   ↓                                     │
│   CustomPracticeStorage._internal()     │
│                                         │
│ _customPractices: List<CustomPractice>  │
│ ├─ CustomPractice                       │
│ │  ├─ id: "1705..."                     │
│ │  ├─ title: "Morning Stretch"          │
│ │  ├─ movements: [...]                  │
│ │  └─ createdAt: DateTime               │
│ │                                       │
│ ├─ CustomPractice                       │
│ │  ├─ id: "1706..."                     │
│ │  ├─ title: "Evening Yoga"             │
│ │  ├─ movements: [...]                  │
│ │  └─ createdAt: DateTime               │
│ │                                       │
│ └─ ...                                  │
│                                         │
│ Methods:                                │
│ • addPractice(CustomPractice)           │
│ • removePractice(String id)             │
│ • getPractice(String id)                │
│ • customPractices (getter)              │
└─────────────────────────────────────────┘

Access from anywhere:
final storage = CustomPracticeStorage();
// Same instance everywhere!
```

---

## Testing Examples

### Example 1: Test CustomPractice Entity

```dart
import 'package:test/test.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';

void main() {
  group('CustomPractice', () {
    test('calculates duration correctly', () {
      final movements = [
        Movement(
          id: '1',
          name: 'Pose 1',
          description: 'Test',
          durationSeconds: 60,
        ),
        Movement(
          id: '2',
          name: 'Pose 2',
          description: 'Test',
          durationSeconds: 120,
        ),
      ];

      final practice = CustomPractice(
        id: 'test',
        title: 'Test',
        movements: movements,
        createdAt: DateTime.now(),
      );

      expect(practice.durationSeconds, 180);
      expect(practice.durationMinutes, 3);
      expect(practice.poseCount, 2);
    });

    test('rounds up duration correctly', () {
      final movements = [
        Movement(
          id: '1',
          name: 'Pose',
          description: 'Test',
          durationSeconds: 100, // 1.67 minutes
        ),
      ];

      final practice = CustomPractice(
        id: 'test',
        title: 'Test',
        movements: movements,
        createdAt: DateTime.now(),
      );

      expect(practice.durationSeconds, 100);
      expect(practice.durationMinutes, 2); // Rounded up
    });
  });
}
```

### Example 2: Test Storage

```dart
test('CustomPracticeStorage works correctly', () {
  final storage = CustomPracticeStorage();
  
  // Should start empty
  expect(storage.customPractices, isEmpty);
  
  // Add practice
  final practice = CustomPractice(
    id: 'test-1',
    title: 'Test',
    movements: [],
    createdAt: DateTime.now(),
  );
  
  storage.addPractice(practice);
  expect(storage.customPractices, hasLength(1));
  
  // Get practice
  final retrieved = storage.getPractice('test-1');
  expect(retrieved, isNotNull);
  expect(retrieved?.title, 'Test');
  
  // Remove practice
  storage.removePractice('test-1');
  expect(storage.customPractices, isEmpty);
});
```

---

## Navigation Examples

### Example 1: Navigation Map

```
Start: Practice Screen
├─ Tap standard practice
│  └─ /practice/1
│     └─ Detail screen
│        ├─ Tap Start
│        └─ /practice/1/playback
│           └─ Playback screen
│
├─ Tap custom practice
│  └─ /practice/custom/custom-123
│     └─ Custom detail screen
│        └─ Tap Start (future)
│           └─ /practice/custom/custom-123/playback (future)
│
└─ Tap FAB
   └─ CreateCustomPracticeScreen dialog
      ├─ Close → Back to practice screen
      └─ Create → Back to practice screen (updated list)
```

### Example 2: Route Configuration

```dart
// From app_routes.dart

GoRoute(
  path: '/practice',
  name: 'practice',
  pageBuilder: (context, state) => NoTransitionPage(
    child: const PracticeScreen(),
  ),
  routes: [
    // Standard practice routes
    GoRoute(
      path: ':id',
      name: 'practiceDetail',
      pageBuilder: (context, state) {
        final practiceId = state.pathParameters['id'] ?? '';
        return NoTransitionPage(
          child: PracticeDetailScreen(practiceId: practiceId),
        );
      },
      routes: [
        GoRoute(
          path: 'playback',
          name: 'practicePlayback',
          pageBuilder: (context, state) {
            final practiceId = state.pathParameters['id'] ?? '';
            return NoTransitionPage(
              child: PracticePlaybackScreen(practiceId: practiceId),
            );
          },
        ),
      ],
    ),
    
    // Custom practice routes (NEW)
    GoRoute(
      path: 'custom/:id',
      name: 'customPracticeDetail',
      pageBuilder: (context, state) {
        final practiceId = state.pathParameters['id'] ?? '';
        return NoTransitionPage(
          child: CustomPracticeDetailScreen(practiceId: practiceId),
        );
      },
    ),
  ],
),
```

### Example 3: Programmatic Navigation

```dart
// In CreateCustomPracticeScreen (after creation)
final customPractice = CustomPractice(...);
Navigator.of(context).pop(customPractice);

// In PracticeScreen (receive result)
final result = await showDialog(
  context: context,
  builder: (context) => const CreateCustomPracticeScreen(),
);

if (result != null) {
  // Can navigate immediately if desired:
  context.go('/practice/custom/${result.id}');
}

// In CustomPracticeTile (on tap)
onTap: () {
  context.go('/practice/custom/${practice.id}');
}
```

---

## Advanced Examples

### Example: Custom Duration Calculation Helper

```dart
extension CustomPracticeFormatter on CustomPractice {
  String get durationDisplay {
    if (durationMinutes < 1) {
      return '${durationSeconds}s';
    } else if (durationSeconds % 60 == 0) {
      return '${durationMinutes}m';
    } else {
      final mins = durationSeconds ~/ 60;
      final secs = durationSeconds % 60;
      return '${mins}m ${secs}s';
    }
  }
  
  String get summary {
    return '$poseCount poses, $durationDisplay';
  }
}

// Usage:
print(practice.durationDisplay);  // "5m 30s"
print(practice.summary);          // "3 poses, 5m 30s"
```

### Example: Batch Operations

```dart
void createDefaultCustomPractices() {
  final storage = CustomPracticeStorage();
  
  final practices = [
    _createMorningFlow(),
    _createEveningRelax(),
    _createQuickStretch(),
  ];
  
  for (final practice in practices) {
    storage.addPractice(practice);
  }
}

CustomPractice _createMorningFlow() {
  // Implementation...
}

CustomPractice _createEveningRelax() {
  // Implementation...
}

CustomPractice _createQuickStretch() {
  // Implementation...
}
```

---

## Troubleshooting Examples

### Issue: Poses Not Appearing After Selection

**Problem**: User selects poses but they don't show in preview

**Solution**: Check setState() is called

```dart
void _toggleMovement(Movement movement) {
  setState(() {  // ← Must call setState!
    if (_selectedMovementIds.contains(movement.id)) {
      _selectedMovementIds.remove(movement.id);
      _selectedMovements.removeWhere((m) => m.id == movement.id);
    } else {
      _selectedMovementIds.add(movement.id);
      _selectedMovements.add(movement);
    }
  });
}
```

### Issue: Wrong Pose Order

**Problem**: Poses appear in wrong order in preview

**Solution**: Check List order, not Set

```dart
// ✅ CORRECT - List maintains order
final _selectedMovements = <Movement>[];

// ❌ WRONG - Set doesn't maintain order
// final _selectedMovements = <Movement>{};

// Always append to list
_selectedMovements.add(movement);  // ← Maintains insertion order
```

### Issue: Storage Not Persisting

**Problem**: Practices lost on app restart

**Expected (v1)**: This is by design (in-memory only)

**Solution (v1.1)**: Add SQLite storage

```dart
// Future implementation:
// 1. Add sqflite package
// 2. Create CustomPracticeDao
// 3. Implement LocalDataSource
// 4. Swap CustomPracticeStorage
```

---

## Performance Examples

### Example: Efficient List Building

```dart
// ✅ GOOD - Uses ListView.builder for large lists
ListView.builder(
  itemCount: mockPractices.length + customPractices.length,
  itemBuilder: (context, index) {
    // Only builds visible items
  },
)

// ❌ BAD - Builds all items at once
Column(
  children: [
    for (final practice in allPractices)
      PracticeTile(practice: practice),
  ],
)
```

### Example: Const Constructors

```dart
// ✅ GOOD - Const constructor reduces rebuilds
const FloatingActionButton(
  onPressed: ...,
  child: Icon(Icons.add),  // ← Const
)

// ❌ BAD - Non-const causes unnecessary rebuilds
FloatingActionButton(
  onPressed: ...,
  child: Icon(Icons.add),  // ← Non-const
)
```

---

**Last Updated**: Dec 30, 2025  
**Status**: Complete and tested  
**Next**: v1.1 with persistence
