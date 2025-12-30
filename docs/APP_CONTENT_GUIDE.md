# AppContent Guide

**Date**: Dec 30, 2025  
**Purpose**: Centralized content management for practices and available poses

---

## Overview

The app content (standard practices and available poses for custom practice creation) is now centralized in a single file for easy maintenance and modification.

**Location**: `lib/core/data/app_content.dart`

---

## Structure

### 1. Standard Practices (3 main practices)

Displayed on the Practice screen. Currently includes:
- **Lotus Flow** (ID: 1) - Beginner, 15 min
- **Tree Pose Balance** (ID: 2) - Beginner, 20 min
- **Warrior Strength** (ID: 3) - Intermediate, 30 min

```dart
final standardPractices = [
  Practice(
    id: '1',
    title: 'Lotus Flow',
    // ...
    movements: availableMovements.where((m) => m.id.startsWith('1-')).toList(),
  ),
  // ...
]
```

**Key**: Practices pull their movements from `availableMovements` using ID prefix matching.

### 2. Available Movements (All poses)

All poses that users can select when creating custom practices. Organized by practice ID:
- `1-*` movements belong to Lotus Flow
- `2-*` movements belong to Tree Pose Balance
- `3-*` movements belong to Warrior Strength

```dart
final availableMovements = [
  Movement(
    id: '1-1',
    name: 'Seated Child\'s Pose',
    description: 'Rest and breathe deeply',
    durationSeconds: 30,
  ),
  // ...
]
```

---

## How to Modify

### Add a New Practice

1. Add a new entry to `standardPractices`:

```dart
Practice(
  id: '4',
  title: 'Your New Practice',
  description: 'Short description',
  fullDescription: 'Long description...',
  durationMinutes: 25,
  difficulty: DifficultyLevel.beginner,
  completedCount: 0,
  iconType: IconType.flexibility,
  movements: availableMovements.where((m) => m.id.startsWith('4-')).toList(),
),
```

2. Add movements with matching prefix (`4-*`) to `availableMovements`:

```dart
// Practice 4 movements (4-x)
Movement(
  id: '4-1',
  name: 'First Pose',
  description: 'Description',
  durationSeconds: 45,
),
// ...
```

### Add Poses to Existing Practice

Simply add new `Movement` objects with the matching practice ID prefix:

```dart
// Add to Lotus Flow (1-x)
Movement(
  id: '1-9',  // Next ID for practice 1
  name: 'New Pose Name',
  description: 'Pose description',
  durationSeconds: 60,
),
```

### Change Practice Details

Edit the existing `Practice` object in `standardPractices`. Changes automatically reflect everywhere.

### Remove a Practice

1. Remove the entry from `standardPractices`
2. Remove or keep the associated movements (they won't be visible if practice ID doesn't reference them)

---

## Important Notes

- **Practice count**: Currently limited to 3 practices on the Practice screen
- **Movements**: All movements in `availableMovements` are available for custom practice creation
- **Naming convention**: Movement IDs must follow `{practiceId}-{movementNumber}` format
- **Backward compatibility**: Old code using `mockPractices` still works (aliased to `standardPractices`)

---

## Files Using AppContent

1. **PracticeScreen** - Displays `standardPractices`
2. **CreateCustomPracticeScreen** - Uses `standardPractices` + `availableMovements` for selection
3. **PracticeDetailScreen** - Shows movements from a practice

---

## Future Enhancements

- [ ] Load practices from database instead of hardcoded
- [ ] Add favorite/pinned practices
- [ ] Allow users to create their own practice categories
- [ ] Sync practices with backend
- [ ] Import/export practice definitions

---

**Last Updated**: Dec 30, 2025
