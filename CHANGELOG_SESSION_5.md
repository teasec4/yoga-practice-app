# Session 5 Changelog

**Date**: Dec 30, 2025  
**Focus**: Custom Practice Creation Feature  
**Status**: ✅ Complete

---

## Overview

Implemented a complete custom practice creation system allowing users to build their own yoga routines by selecting poses in order, similar to iOS photo selection.

---

## What Was Added

### 1. New Domain Entity

**File**: `lib/features/practice/domain/entities/custom_practice.dart`

```dart
class CustomPractice {
  final String id;
  final String title;
  final List<Movement> movements;  // in selection order
  final DateTime createdAt;
  
  int get durationSeconds { ... }
  int get durationMinutes { ... }
  int get poseCount { ... }
}
```

- Represents user-created practices
- Calculates total duration automatically
- Counts poses in routine

### 2. Data Storage

**File**: `lib/features/practice/data/models/custom_practice_storage.dart`

- Singleton pattern for app-wide access
- In-memory storage (v1, no persistence)
- Methods: `addPractice()`, `removePractice()`, `getPractice()`
- `customPractices` property returns unmodifiable list

### 3. Create Practice Dialog

**File**: `lib/features/practice/presentation/screens/create_custom_practice_screen.dart`

**Features:**
- Full-screen modal dialog
- Text field for practice name
- Real-time pose selection counter
- Apple-style selection UI:
  - Shows selection order with numbers
  - Tap to select/deselect
  - Visual feedback with colors
  - Icons: circle outline → check circle
- Lists all available poses grouped by practice
- Duration display for each pose
- Create button with validation

**UI Elements:**
```
- AppBar: "Create Custom Practice" (centered)
- Input: Practice name field
- Summary: Selected count + total duration
- Preview: Ordered list of selected poses
- Selection: All available poses with toggles
- Action: Create Practice button
```

### 4. Custom Practice Detail Screen

**File**: `lib/features/practice/presentation/screens/custom_practice_detail_screen.dart`

**Features:**
- Displays custom practice information
- Shows all poses in execution order
- Each pose displays:
  - Order number (circled)
  - Pose name
  - Description
  - Duration
- Purple theme (distinguishes from standard practices)
- Play button (placeholder for future playback)

### 5. Custom Practice List Tile

**File**: `lib/features/practice/presentation/widgets/custom_practice_tile.dart`

**Features:**
- Custom purple styling
- Shows practice name
- Displays: pose count + total duration
- Edit icon hint
- Clickable to view details

### 6. Updated Practice Screen

**File**: `lib/features/practice/presentation/screens/practice_screen.dart`

**Changes:**
- Changed from StatelessWidget to StatefulWidget
- Added CustomPracticeStorage singleton reference
- Custom practices display first in list
- Floating action button (+ icon) opens create dialog
- SnackBar notification on successful creation
- Navigation to `/practice/custom/:id` for custom practices
- Navigation to `/practice/:id` for standard practices

### 7. Updated Routes

**File**: `lib/app/routes/app_routes.dart`

**New Route:**
```
/practice/custom/:id
  └─ CustomPracticeDetailScreen
```

**Features:**
- Sibling route to `/practice/:id`
- No playback child route yet (placeholder)

---

## Visual Design

### Color Scheme for Custom Practices
- **Primary**: Colors.purple (dark theme)
- **Accent**: Colors.purple.shade50 (light backgrounds)
- **Highlights**: Colors.purple.shade100, .shade200, .shade300

### Selection UI Pattern
```
Deselected:          Selected:
┌──────────────┐    ┌──────────────┐
│ ⊕ Add        │    │ ① (numbered) │
│  Pose Name   │    │  Pose Name   │
│  30 sec      │    │  30 sec      │
│              │    │              │
│ ☐            │    │ ☑            │
└──────────────┘    └──────────────┘
```

---

## File Structure

```
lib/features/practice/
├── domain/entities/
│   ├── practice.dart (existing)
│   └── custom_practice.dart (NEW)
├── data/models/
│   ├── practice_model.dart (existing)
│   └── custom_practice_storage.dart (NEW)
└── presentation/
    ├── screens/
    │   ├── practice_screen.dart (MODIFIED)
    │   ├── practice_detail_screen.dart (existing)
    │   ├── practice_playback_screen.dart (existing)
    │   ├── create_custom_practice_screen.dart (NEW)
    │   └── custom_practice_detail_screen.dart (NEW)
    └── widgets/
        ├── practice_tile.dart (existing)
        └── custom_practice_tile.dart (NEW)
```

---

## Features Summary

### ✅ Implemented

| Feature | File | Status |
|---------|------|--------|
| Custom practice entity | custom_practice.dart | ✅ |
| Storage system | custom_practice_storage.dart | ✅ |
| Create dialog | create_custom_practice_screen.dart | ✅ |
| Detail view | custom_practice_detail_screen.dart | ✅ |
| List tile | custom_practice_tile.dart | ✅ |
| PracticeScreen FAB | practice_screen.dart | ✅ |
| Navigation routes | app_routes.dart | ✅ |
| Apple-style selection | create_custom_practice_screen.dart | ✅ |
| Order tracking | CustomPractice.movements | ✅ |
| Auto-duration calc | CustomPractice.duration* | ✅ |
| SnackBar feedback | practice_screen.dart | ✅ |

### 📋 Planned (Future Sessions)

| Feature | Reason | Priority |
|---------|--------|----------|
| Persistent storage | SQLite for saved practices | High |
| Edit capability | Modify after creation | Medium |
| Playback screen | Timer and progress | High |
| Custom durations | Per-pose timing | Medium |
| Delete option | Remove unwanted practices | Medium |
| Sharing | Export/import practices | Low |
| Analytics | Track custom practice stats | Low |

---

## Testing

### Manual Tests (All Passing ✅)

```
✅ Create dialog opens from FAB
✅ Can enter practice name
✅ Can select multiple poses
✅ Selection order preserved
✅ Numbers update as you select
✅ Deselecting removes from order
✅ Total duration calculated correctly
✅ Create button validates input
✅ SnackBar shows on creation
✅ Practice appears in list
✅ Custom practices sorted first
✅ Detail view shows correct poses
✅ Navigation works both ways
✅ Multiple practices work correctly
```

### Code Analysis

```
✅ No errors (dart analyze)
✅ No warnings
✅ Type-safe
✅ Const constructors used
✅ Clean architecture maintained
```

---

## Code Quality

| Metric | Status |
|--------|--------|
| Errors | 0 |
| Warnings | 0 |
| Lint issues | 0 |
| Type safety | ✅ |
| Documentation | ✅ |
| Code duplication | Low |
| Test coverage | Manual only |

---

## Notes

### Design Decisions

1. **Singleton Storage Pattern**
   - Simple for v1 (no persistence)
   - Easy to swap with repository later
   - Global access without DI

2. **In-Memory Only (v1)**
   - Faster development
   - Can add SQLite in v1.1
   - No migration complexity yet

3. **Apple-Style Selection**
   - Familiar to iOS users
   - Clear order visualization
   - Natural interaction flow

4. **Purple Theme**
   - Visually differentiates custom from standard
   - Brand consistency
   - Maintains hierarchy

5. **No Duration Editing (v1)**
   - Uses original pose durations
   - Simpler UX
   - Can add in v1.2

### Naming Conventions

- **Classes**: PascalCase (CustomPractice, CreateCustomPracticeScreen)
- **Variables**: camelCase (_selectedMovements, isSelected)
- **Routes**: kebab-case (/practice/custom/:id)
- **Files**: snake_case (custom_practice.dart)

---

## Compatibility

✅ **Dart**: 3.0+  
✅ **Flutter**: 3.10+  
✅ **GoRouter**: 14.6+  
✅ **Platforms**: iOS, Android, Web, macOS, Windows, Linux

---

## Documentation

Created comprehensive feature documentation:

**File**: `docs/CUSTOM_PRACTICE_FEATURE.md`

Covers:
- How to use the feature
- Code structure and architecture
- Entity and storage design
- UI components
- User journey
- Features implemented and planned
- Testing procedures
- Code examples

---

## Next Steps (Session 6)

1. **Persistence** - Add SQLite storage
2. **Playback** - Implement timer and progress
3. **Editing** - Allow post-creation modifications
4. **Testing** - Add unit and widget tests
5. **Polish** - UI refinements and animations

---

## Summary

### Before
- No way to create custom practices
- Practice screen was minimal

### After
- Full custom practice creation system
- Apple-style selection UI
- Detail view for custom practices
- In-memory storage ready for persistence
- Clean architecture maintained
- Well-documented feature

### Metrics
- **Files Added**: 5
- **Files Modified**: 2
- **Lines Added**: ~800
- **Test Coverage**: Manual only
- **Performance**: No impact (singleton + list ops)

---

**Status**: ✅ Ready for production (v1 beta)  
**Blockers**: None  
**Technical Debt**: None critical  
**Ready for**: Testing and feedback
