# Session 1: App Skeleton and Architecture Setup

**Date**: December 29, 2025  
**Goal**: Create app skeleton with architectural best practices, bottom navigation with 3 screens

## Overview
Yoga Coach is a platform where users can:
- Find and practice yoga exercises
- Create custom practices
- Track training statistics
- Manage app settings

## Architecture

### Folder Structure (Feature-Based)
```
lib/
├── main.dart                           # App entry point
├── app/
│   ├── app.dart                        # App configuration & navigation
│   └── routes.dart                     # Route definitions (future)
├── features/
│   ├── lessons/
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── lessons_screen.dart
│   │   │   ├── widgets/
│   │   │   └── providers/              # State management
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── data/
│   │       ├── models/
│   │       ├── repositories/
│   │       └── datasources/
│   ├── statistics/
│   │   ├── presentation/
│   │   ├── domain/
│   │   └── data/
│   └── settings/
│       ├── presentation/
│       ├── domain/
│       └── data/
└── core/
    ├── constants/
    ├── theme/
    └── utils/
```

### Design Principles
- **Clean Architecture**: Separation of concerns (presentation, domain, data)
- **State Management**: Ready for Provider/Riverpod/Bloc implementation
- **Testability**: Loose coupling, dependency injection ready
- **Scalability**: Modular structure for feature growth

## Implementation Details

### 1. Navigation Setup
- **GoRouter**: Modern declarative routing with `go_router: ^14.2.0`
- **ShellRoute**: Wraps navigation screens with MainShell layout
- **3 Routes**: `/lessons`, `/statistics`, `/settings`
- Initial route: `/lessons`

### 2. File Structure
```
lib/app/
├── app.dart             # App config with MaterialApp.router
└── routes/
    ├── app_routes.dart  # GoRouter config + ShellRoute
    └── main_shell.dart  # Shell layout with BottomNavigationBar
```

### 3. Screen Stubs
All screens implement basic placeholder layouts:
- **LessonsScreen**: "Lessons" placeholder
- **StatisticsScreen**: "Statistics" placeholder  
- **SettingsScreen**: "Settings" placeholder

### 4. Bottom Navigation
- Built into MainShell wrapper
- Routes updated via `context.go(path)` on tab tap
- Tab selection syncs with current route location

## Theme & Colors

### Color Palette (Yoga-inspired)
- **Primary**: Soft Purple (#9B7FB3 / #7B5FA3) - Meditation, Spirituality
- **Secondary**: Soft Green (#8BC98D / #6BA86D) - Nature, Balance, Growth
- **Tertiary**: Warm Sand (#E8D5C4 / #D4B8A8) - Grounding, Warmth
- **Accent**: Soft Blue (#ADD4E0 / #8FB3C5) - Calmness, Clarity

### Theme System
- Light & Dark themes with system preference detection
- `AppTheme` class with `lightTheme()` and `darkTheme()`
- All colors centralized in `AppColors`
- Full typography configuration

## Next Steps
1. Add state management (Provider/Riverpod)
2. Create reusable UI components
3. Implement data models and repositories
4. Add lesson list UI
5. Implement statistics display
6. Add settings functionality

## Files Created/Modified

### Core App Files
- `lib/main.dart` - Entry point
- `lib/app/app.dart` - App config with MaterialApp.router
- `pubspec.yaml` - Added go_router dependency

### Navigation Files
- `lib/app/routes/app_routes.dart` - GoRouter config + ShellRoute definition
- `lib/app/routes/main_shell.dart` - MainShell layout wrapper

### Feature Screen Files
- `lib/features/lessons/presentation/screens/lessons_screen.dart`
- `lib/features/statistics/presentation/screens/statistics_screen.dart`
- `lib/features/settings/presentation/screens/settings_screen.dart`

### Folder Structure (initialized)
```
lib/features/
├── lessons/
│   ├── presentation/screens/
│   ├── domain/(entities, repositories, usecases)
│   └── data/(models, repositories, datasources)
├── statistics/
│   ├── presentation/screens/
│   ├── domain/
│   └── data/
└── settings/
    ├── presentation/screens/
    ├── domain/
    └── data/
```

## Session Progress Log

### Changes Made
1. ✅ Feature-based architecture setup
2. ✅ GoRouter navigation system with ShellRoute
3. ✅ Custom segment switcher for Practice tabs
4. ✅ Practice list with 10 mock items and PracticeTile widget
5. ✅ Practice detail screen with full information
6. ✅ Settings screen with mock options
7. ✅ Google Fonts (Poppins) integration
8. ✅ Dual light/dark theme with yoga-inspired colors
9. ✅ Elevated AppBar with shadow
10. ✅ No-transition page navigation
11. ✅ Renamed "Lessons" to "Practice" throughout codebase

### Refactoring Completed
- Renamed `/features/lessons/` → `/features/practice/`
- Updated all class names: `Lesson` → `Practice`
- Updated UI text: "Lessons" → "Practice"
- Updated routes: `/lessons/` → `/practice/`
- Updated all imports and dependencies

## How to Run
```bash
flutter pub get
flutter run
```

The app will start with bottom navigation showing Practice, Statistics, and Settings tabs.

## Color Theme Applied
- **AppBar**: Primary color (soft purple) with elevation shadow
- **Navigation**: Matches primary color scheme
- **Text**: Poppins font throughout
- **Accents**: Secondary and accent colors for highlights
