# Custom Practice Feature

**Date**: Dec 30, 2025  
**Feature**: Create custom yoga practices by selecting poses in order  
**Status**: ✅ Implementation Complete

---

## Overview

Users can now create their own custom yoga practices by:
1. Tapping the floating action button (+ button) on Practice screen
2. Entering a name for the practice
3. Selecting poses from existing practices in order (like iOS photo selection)
4. Viewing created practices in the list

---

## How It Works

### Selection Model (Apple-Style)

- **Order matters**: Taps are in the order you add poses
- **Visual feedback**: Shows position number (1, 2, 3...) as you select
- **Editable**: Deselect by tapping again to remove from order
- **Preview**: See selected poses with timing in real-time

### Default Duration

- Each pose uses its original duration from the source practice
- Total duration calculated automatically
- No manual duration editing (v1 implementation)

---

## Code Structure

### New Files Created

```
lib/features/practice/
├── domain/entities/
│   └── custom_practice.dart          # Custom practice entity
├── data/models/
│   └── custom_practice_storage.dart  # In-memory storage (singleton)
├── presentation/
│   ├── screens/
│   │   ├── create_custom_practice_screen.dart    # Selection dialog
│   │   └── custom_practice_detail_screen.dart    # Detail view
│   └── widgets/
│       └── custom_practice_tile.dart # Custom practice list item
```

### Modified Files

- `practice_screen.dart` - Added FAB and custom practice support
- `app_routes.dart` - Added `/practice/custom/:id` route

---

## Entity: CustomPractice

```dart
class CustomPractice {
  final String id;                        // Timestamp-based ID
  final String title;                     // User-given name
  final List<Movement> movements;         // In selection order
  final DateTime createdAt;               // Creation timestamp

  int get durationSeconds { ... }
  int get durationMinutes { ... }
  int get poseCount { ... }
}
```

---

## UI Components

### 1. Create Dialog (`CreateCustomPracticeScreen`)

**Features:**
- Full-screen dialog with AppBar
- Text field for practice name
- Summary: selected poses count + total duration
- Preview section: shows poses in order with numbers
- List of all available poses grouped by practice
- Modern selection UI with:
  - Circle indicator showing selection order
  - Checkmark icon when selected
  - Color-coded highlights

**Example:**
```
┌─────────────────────────────┐
│ Create Custom Practice    ✕ │
├─────────────────────────────┤
│ [Practice Name...]          │
│                             │
│ Selected: 3 | Total: 5 min  │
│                             │
│ Poses in Order:             │
│ ① Lotus Pose (60s)          │
│ ② Tree Pose (45s)           │
│ ③ Warrior I (60s)           │
│                             │
│ ─────────────────────────   │
│                             │
│ Available Poses:            │
│ ⊕ Downward Dog (30s)   ☐    │
│ ✓ Lotus Pose (60s)     ☑    │
│ ...                         │
│                             │
│ ┌─ Create Practice ┐        │
└─────────────────────────────┘
```

### 2. Detail Screen (`CustomPracticeDetailScreen`)

**Features:**
- Shows custom practice info
- Lists all poses in order with numbers
- Shows duration for each pose
- Play button to start practice (placeholder)
- Purple theme (differentiates from standard practices)

### 3. List Tile (`CustomPracticeTile`)

**Features:**
- Purple styling for visual distinction
- Shows: name, pose count, total duration
- Edit icon hint for future editing

---

## Storage: CustomPracticeStorage

**Type**: Singleton pattern  
**Scope**: In-memory (app session only)  
**Persistence**: Not implemented yet (v1)

```dart
class CustomPracticeStorage {
  static final _instance = CustomPracticeStorage._internal();

  final List<CustomPractice> _customPractices = [];

  void addPractice(CustomPractice practice) { ... }
  void removePractice(String id) { ... }
  CustomPractice? getPractice(String id) { ... }
  List<CustomPractice> get customPractices { ... }
}
```

---

## User Journey

1. **Open Practice tab**
   - See all default practices
   - See custom practices at top (if any)
   - Bottom-right FAB: "+" button

2. **Tap FAB**
   - Modal dialog opens: "Create Custom Practice"

3. **Enter Practice Name**
   - Text field with placeholder
   - Min 1 character to create

4. **Select Poses**
   - Browse all practices and their poses
   - Tap any pose to select/deselect
   - Selection order matches tap order
   - Circle number shows position
   - Real-time preview updates

5. **Create**
   - Tap "Create Practice" button
   - Dialog closes
   - SnackBar confirms creation
   - Practice appears at top of list

6. **View Custom Practice**
   - Tap custom practice tile
   - Navigate to detail screen
   - See all poses in execution order
   - "Start Practice" button (placeholder)

---

## Routes

### New Route Added

```
/practice/custom/:id
├── Leads to: CustomPracticeDetailScreen
├── Parameter: practiceId (string)
├── Parent: /practice
└── No child routes
```

### Existing Routes (Modified)

```
/practice
├── now displays custom practices first
├── floating action button opens create dialog
└── custom practices navigate to /practice/custom/:id
```

---

## State Management

**Current**: Simple StatefulWidget in PracticeScreen
- Stores reference to CustomPracticeStorage singleton
- Rebuilds on practice creation
- Shows SnackBar confirmation

**Future**: Riverpod
- Global state for custom practices
- Persistent storage (SQLite)
- History and analytics

---

## Features Implemented ✅

- [x] CustomPractice entity with duration calculation
- [x] Create dialog with Apple-style selection
- [x] Pose selection with order tracking
- [x] Visual feedback (numbers, highlights, icons)
- [x] In-memory storage (singleton pattern)
- [x] Detail screen for custom practices
- [x] Navigation routes
- [x] List display with custom tile
- [x] SnackBar notifications

---

## Features Planned 📋

### v1.1 - Persistence
- [ ] SQLite storage
- [ ] Load saved practices on app launch
- [ ] Data migration helper

### v1.2 - Editing
- [ ] Edit existing custom practices
- [ ] Delete custom practices
- [ ] Reorder poses after creation
- [ ] Change individual pose durations

### v1.3 - Playback
- [ ] Implement playback screen for custom practices
- [ ] Timer for each pose
- [ ] Progress indicator
- [ ] Audio cues between poses

### v2.0 - Advanced
- [ ] Favorite/pin custom practices
- [ ] Share custom practices
- [ ] Import from community
- [ ] Statistics tracking
- [ ] Custom pose descriptions

---

## Code Examples

### Create a Custom Practice (Programmatically)

```dart
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';

final customPractice = CustomPractice(
  id: '123',
  title: 'My Morning Flow',
  movements: [
    Movement(
      id: '1-1',
      name: 'Child\'s Pose',
      description: 'Rest',
      durationSeconds: 30,
    ),
    Movement(
      id: '2-3',
      name: 'Cat-Cow Stretch',
      description: 'Warm up',
      durationSeconds: 45,
    ),
  ],
  createdAt: DateTime.now(),
);

// Store it
final storage = CustomPracticeStorage();
storage.addPractice(customPractice);
```

### Get a Custom Practice

```dart
final storage = CustomPracticeStorage();
final practice = storage.getPractice('123');

if (practice != null) {
  print('${practice.title}: ${practice.durationMinutes} min');
  print('${practice.poseCount} poses');
}
```

### Navigate to Custom Practice

```dart
context.go('/practice/custom/123');
```

---

## Testing

### Manual Testing Steps

1. **Create Practice**
   - [ ] Tap FAB on Practice screen
   - [ ] Enter name
   - [ ] Select 3+ poses
   - [ ] Verify order shown correctly
   - [ ] Tap Create
   - [ ] See SnackBar confirmation

2. **View Practice**
   - [ ] Custom practice appears at top
   - [ ] Purple styling visible
   - [ ] Tap to open detail
   - [ ] All poses shown in order
   - [ ] Durations correct

3. **Multiple Practices**
   - [ ] Create 3 different practices
   - [ ] All appear in list
   - [ ] Each has correct poses
   - [ ] No mix-up between them

4. **Edge Cases**
   - [ ] Empty name: shows error
   - [ ] No poses: shows error
   - [ ] Deselect while creating: works
   - [ ] Close dialog: cancels creation

### Unit Tests (Planned)

```dart
test('CustomPractice calculates duration correctly', () {
  final practice = CustomPractice(
    id: '1',
    title: 'Test',
    movements: [
      Movement(..., durationSeconds: 60),
      Movement(..., durationSeconds: 120),
    ],
    createdAt: DateTime.now(),
  );
  
  expect(practice.durationSeconds, 180);
  expect(practice.durationMinutes, 3);
  expect(practice.poseCount, 2);
});
```

---

## Performance Considerations

**✅ Optimized:**
- Singleton storage reduces allocations
- Const constructors used
- List operations efficient (adding/removing)

**🔄 Future Optimization:**
- Lazy load pose lists (only show visible practices)
- Cache movement data
- Limit custom practices in memory

---

## Known Limitations (v1)

1. **No Persistence** - Practices lost on app restart
2. **No Editing** - Can't modify after creation
3. **No Playback** - Detail screen only, no timer
4. **No Durations** - Can't customize per-pose timing
5. **No Sharing** - Can't export/share practices
6. **No Undo** - No cancel after creation (except close app)

---

## Next Steps

1. **Implement persistence** (SQLite)
2. **Add editing capability**
3. **Build playback timer**
4. **Add UI for custom durations**
5. **Implement statistics tracking**

---

**Status**: Ready for testing and iteration  
**Last Updated**: Dec 30, 2025
