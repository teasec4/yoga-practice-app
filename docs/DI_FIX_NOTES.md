# GetIt DI Fix Notes

**Date**: Dec 30, 2025  
**Issue**: PlaybackCubit GetIt registration mismatch  
**Status**: ✅ Fixed

## Problem

When starting practice playback, got:
```
Bad state: GetIt: Object/factory with type PracticeRepository is
not registered inside GetIt.
```

## Root Cause

In `service_locator.dart`, we registered the repository as `PracticeRepo` (interface):

```dart
getIt.registerSingleton<PracticeRepo>(
  PracticeRepository(database: getIt<AppDatabase>()),
);
```

But `createPlaybackCubit()` was trying to get `PracticeRepository` (concrete class):

```dart
repository: getIt<PracticeRepository>(),  // ← GetIt couldn't find this
```

## Solution

Register the **same instance** under **both types**:

```dart
// Repositories
final practiceRepository = PracticeRepository(
  database: getIt<AppDatabase>(),
);

// Register as both concrete type AND interface
getIt.registerSingleton<PracticeRepository>(practiceRepository);
getIt.registerSingleton<PracticeRepo>(practiceRepository);
```

This way:
- `PracticeBloc` can get it as `PracticeRepo` (interface)
- `PlaybackCubit` can get it as `PracticeRepository` (concrete type)
- Both share the **same singleton instance** (no duplicate objects)

## Files Changed

- `lib/core/di/service_locator.dart` — Fixed registration pattern

## Verification

✅ No compilation errors  
✅ All GetIt lookups will succeed  
✅ Playback should start without errors

## Pattern: Multiple Type Registration

```dart
// Register single instance as multiple types
final service = MyService();
getIt.registerSingleton<MyService>(service);
getIt.registerSingleton<IMyService>(service);  // Same instance as interface

// Later, both work:
final s1 = getIt<MyService>();      // ✅ Works
final s2 = getIt<IMyService>();     // ✅ Works
// s1 == s2  → true (same object)
```

This pattern is useful for dependency injection where:
- Different components expect different types
- But you want to maintain a single instance

---

**Status**: ✅ Complete
