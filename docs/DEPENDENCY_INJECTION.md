# Dependency Injection (GetIt)

**Date**: Dec 30, 2025  
**Status**: ✅ Implemented

## Overview

The application uses **GetIt** service locator for dependency injection, replacing manual provider setup.

## Architecture

### Service Locator Pattern

```dart
// lib/core/di/service_locator.dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register singletons
  getIt.registerSingleton<AppDatabase>(...);
  getIt.registerSingleton<PracticeRepo>(...);
  getIt.registerSingleton<PracticeBloc>(...);
  
  // Register factories for parameterized instances
  getIt.registerFactory<PlaybackCubit>(...);
}
```

## Registration Strategy

### Singletons (Lazy or Eager)

**When to use**: Services that maintain state or should exist once per app lifetime

- **AppDatabase** - SQLite database instance
- **PracticeRepository** - Data access layer
- **PracticeBloc** - App-wide BLoC for practice management

### Factories

**When to use**: Objects that need parameters or multiple instances

- **PlaybackCubit** - Created per screen with specific `practiceId`

Helper function:
```dart
PlaybackCubit createPlaybackCubit(String practiceId) {
  return PlaybackCubit(
    practiceId: practiceId,
    repository: getIt<PracticeRepository>(),
  );
}
```

## Initialization

### 1. In main.dart

```dart
void main() {
  setupServiceLocator();  // Initialize before app starts
  runApp(const YogaCoachApp());
}
```

### 2. In app.dart

```dart
@override
Widget build(BuildContext context) {
  return BlocProvider<PracticeBloc>(
    create: (context) => getIt<PracticeBloc>()..getAllPractices(),
    child: MaterialApp.router(...),
  );
}
```

### 3. In screens

```dart
// For factory instances with parameters
BlocProvider(
  create: (context) => createPlaybackCubit(widget.practiceId),
  child: BlocBuilder<PlaybackCubit, PlaybackState>(...),
)
```

## Dependency Graph

```
AppDatabase (Singleton)
    ↓
PracticeRepository (Singleton) - implements PracticeRepo
    ↓
PracticeBloc (Singleton)
    ↓
BlocProvider<PracticeBloc> in YogaCoachApp

PlaybackCubit (Factory) - created per screen
    ↓ (uses)
PracticeRepository (from getIt)
```

## Benefits

✅ **Cleaner Code** - No manual provider chains  
✅ **Testability** - Easy to replace with mocks  
✅ **Scalability** - Add new services easily  
✅ **Loose Coupling** - Components don't know about DI  
✅ **Lazy Loading** - Services instantiated on demand

## Adding New Dependencies

### 1. Create the service/repository

```dart
// lib/features/workout/data/repositories/workout_repository.dart
class WorkoutRepository implements WorkoutRepo {
  final AppDatabase database;
  WorkoutRepository({required this.database});
  // ...
}
```

### 2. Register in service_locator.dart

```dart
void setupServiceLocator() {
  // ... existing registrations ...
  
  // New repository
  getIt.registerSingleton<WorkoutRepo>(
    WorkoutRepository(database: getIt<AppDatabase>()),
  );
}
```

### 3. Use in BLoCs or screens

```dart
// In BLoC
class WorkoutBloc extends Cubit<WorkoutState> {
  WorkoutBloc(this.workoutRepo) : super(WorkoutInitial());
  final WorkoutRepo workoutRepo;
}

// In app.dart
BlocProvider(
  create: (context) => getIt<WorkoutBloc>(),
  child: MaterialApp.router(...),
)
```

## Testing

### Replace with Mock

```dart
// In test setup
void setUp() {
  getIt.reset();  // Clear all registrations
  
  // Register mocks
  getIt.registerSingleton<PracticeRepo>(
    MockPracticeRepository(),
  );
  getIt.registerSingleton<PracticeBloc>(
    PracticeBloc(getIt<PracticeRepo>()),
  );
}
```

## File Structure

```
lib/
├── core/
│   └── di/
│       └── service_locator.dart      # DI setup
├── main.dart                          # Call setupServiceLocator()
└── app/
    └── app.dart                       # Use getIt<PracticeBloc>()
```

## Dependencies

```yaml
dependencies:
  get_it: ^7.6.0  # Service locator
```

## Comparison: Before vs After

### Before (Manual Providers)

```dart
// app.dart
return RepositoryProvider(
  create: (context) => PracticeRepository(database: db),
  child: BlocProvider(
    create: (context) => PracticeBloc(
      context.read<PracticeRepository>(),
    ),
    child: MaterialApp.router(...),
  ),
);
```

### After (GetIt)

```dart
// main.dart
setupServiceLocator();

// app.dart
return BlocProvider<PracticeBloc>(
  create: (context) => getIt<PracticeBloc>(),
  child: MaterialApp.router(...),
);
```

## Next Steps

- [ ] Add error logging service
- [ ] Add analytics service
- [ ] Add preferences/settings service
- [ ] Create environment-specific service locators (dev/prod)

---

**Status**: ✅ Complete  
**Next**: Add more services as features expand
