# Application Architecture

## Overview

Yoga Coach follows **Clean Architecture** with **feature-based organization** and **GoRouter** for navigation.

## Directory Structure

```
lib/
├── main.dart                          # App entry point
│
├── app/
│   └── routes/
│       ├── app_routes.dart           # GoRouter configuration (all routes)
│       └── main_shell.dart           # ShellRoute wrapper (bottom nav)
│
├── features/
│   ├── practice/                     # Practice feature
│   │   ├── domain/
│   │   │   └── entities/
│   │   │       └── practice.dart      # Practice & Movement entities
│   │   ├── data/
│   │   │   └── models/
│   │   │       └── practice_model.dart # Mock data
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── practice_screen.dart             # List of practices
│   │       │   ├── practice_detail_screen.dart      # Practice details
│   │       │   └── practice_playback_screen.dart    # Playback interface
│   │       └── widgets/
│   │           └── practice_tile.dart               # Practice list item
│   │
│   ├── statistics/                   # Explore/Discover feature
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── statistics_screen.dart  # Popular & newest workouts
│   │       └── widgets/
│   │           ├── workout_section.dart
│   │           └── workout_card.dart
│   │
│   ├── me/                            # User profile feature (planned)
│   │   └── presentation/
│   │       └── screens/
│   │           └── me_screen.dart      # Profile & achievements
│   │
│   └── settings/                      # Settings feature (planned)
│
└── core/
    └── theme/
        └── app_theme.dart            # Light & dark themes
```

## Architectural Layers

### Domain Layer
- **Purpose**: Business logic and entities
- **Files**: `domain/entities/`
- **Example**: `Practice` class (data structure, no Flutter dependencies)

### Data Layer
- **Purpose**: Data sources and models
- **Files**: `data/models/`
- **Current**: Mock data only (Firebase planned)

### Presentation Layer
- **Purpose**: UI screens and widgets
- **Files**: `presentation/screens/` and `presentation/widgets/`
- **State**: Minimal stateful widgets (will use Riverpod later)

## Navigation Architecture

### Router Configuration
```dart
// app_routes.dart
ShellRoute(
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    GoRoute(path: '/practice', ...)
    GoRoute(path: '/statistics', ...)
    GoRoute(path: '/me', ...)
  ]
)
```

### Bottom Navigation (MainShell)
```dart
// main_shell.dart
- Wraps all routes
- Persists across navigation
- 3 tabs: Practice, Explore, Me
- Tab detection by route path
```

### Route Hierarchy
```
ShellRoute (MainShell)
├── Practice Tab
│   ├── /practice (root)
│   ├── /practice/:id (detail)
│   └── /practice/:id/playback (playback)
├── Explore Tab
│   └── /statistics (root)
└── Me Tab
    └── /me (root)
```

## State Management Strategy

### Current: Minimal StatefulWidget
- Simple setState() for UI updates
- State lives in screen widgets
- Good for: Simple features, low complexity

### Future: Riverpod
- Planned for Phase 2
- Global state management
- Share state between features
- Easier testing

## Theme System

### ThemeData Creation
```dart
// core/theme/app_theme.dart
ThemeData buildLightTheme()
ThemeData buildDarkTheme()
```

### Color Palette
```
Primary:   #9B7FB3 (light), #7B5FA3 (dark)
Secondary: #8BC98D (light), #6BA86D (dark)
Accent:    #ADD4E0 (light), #8FB3C5 (dark)
```

### Typography
- Font: Poppins (Google Fonts)
- Headline Large: 32px, 700 weight
- Body Medium: 14px, 400 weight

## Clean Architecture Benefits

### ✅ Separation of Concerns
- Domain: Pure business logic
- Data: External data handling
- Presentation: UI only

### ✅ Testability
- Domain entities are easy to test
- Mock data for development
- Can swap implementations

### ✅ Maintainability
- Features are isolated
- Clear dependency direction
- Easy to add new features

### ✅ Scalability
- Add new features without affecting others
- Share common widgets
- Reuse domain logic

## Dependency Injection

### Current: Direct imports
```dart
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';
final practice = mockPractices.first;
```

### Future: Service Locator (GetIt)
```dart
// Planned for Phase 2
final repo = getIt<PracticeRepository>();
```

## Feature Addition Checklist

When adding a new feature (e.g., "Nutrition"):

1. **Create folder**: `features/nutrition/`
2. **Domain layer**: `domain/entities/nutrition.dart`
3. **Data layer**: `data/models/nutrition_model.dart`
4. **Presentation**: 
   - `presentation/screens/nutrition_screen.dart`
   - `presentation/widgets/*_widget.dart`
5. **Routes**: Add to `app_routes.dart`
6. **Navigation**: Add to `main_shell.dart`
7. **Theme**: Update `core/theme/` if needed

## Performance Considerations

### ✅ Implemented
- No animations (instant navigation)
- ListView.builder for lists
- Const constructors where possible
- No global state (isolated widgets)

### 🔄 Planned
- Image caching
- Database caching
- Pagination for large lists
- Code splitting

## Testing Strategy

### Unit Tests
- Domain entities
- Pure functions
- Data models

### Widget Tests
- UI components
- Navigation flows
- User interactions

### Integration Tests
- Full app flows
- API integration

## Deployment

### Supported Platforms
- ✅ iOS (11.0+)
- ✅ Android (API 21+)
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

### Build Configuration
```bash
# Debug
flutter run

# Release (iOS)
flutter build ios --release

# Release (Android)
flutter build apk --release
```

## Technology Stack

| Layer | Technology | Version |
|-------|-----------|---------|
| Framework | Flutter | 3.10+ |
| Language | Dart | 3.0+ |
| Navigation | GoRouter | 14.6+ |
| UI | Material Design 3 | Latest |
| Typography | Google Fonts | Latest |
| Database | SQLite | Planned |
| Backend | Firebase | Planned |

---

**Last Updated**: Dec 30, 2025  
**Architecture**: Clean + Feature-based  
**Status**: Stable (ready for feature expansion)
