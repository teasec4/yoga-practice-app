# Session 4 Fixes - Navigation & GlobalKey Issues

## Problems Fixed

### 1. GlobalKey Widget Layout Errors
**Error**: "Each child must be laid out exactly once" and "A GlobalKey was used multiple times inside one widget's child list"

**Root Cause**: The movement grid modal in `practice_playback_screen.dart` used conditional rendering with `if (_showMovementMap)` inside a Stack's children list. This caused Flutter's layout system to fail when rapidly switching tabs or toggling the map visibility.

**Solution**:
- Replaced conditional child rendering with `IgnorePointer` wrapper
- Used `SizedBox.shrink()` for hidden elements instead of removing them from the widget tree
- This keeps the widget hierarchy consistent and avoids layout thrashing

**Files Changed**:
- `lib/features/practice/presentation/screens/practice_playback_screen.dart` (lines 657-691)

### 2. Tab Switching from Playback Screen
**Error**: Tabs wouldn't switch when clicked from the practice playback screen

**Root Cause**: Mixing Navigator and GoRouter - the code used `Navigator.of(context).pop()` which conflicts with GoRouter's navigation stack management.

**Solution**:
- Changed `Navigator.of(context).pop()` to `context.pop()` for GoRouter compatibility
- Added `popUntil()` logic in `MainShell` to gracefully exit playback before switching tabs
- This ensures the navigation stack is properly maintained

**Files Changed**:
- `lib/features/practice/presentation/screens/practice_playback_screen.dart` (lines 140-151)
- `lib/app/routes/main_shell.dart` (lines 20-42)

### 3. AnimationController Safety
**Error**: setState called on unmounted widgets when switching tabs

**Root Cause**: Timer animation controller had listeners without mounted checks, causing errors when the screen was being disposed.

**Solution**:
- Added `if (mounted)` check in timer animation listener
- Added `deactivate()` lifecycle method to pause timer when screen becomes inactive
- This prevents animation callbacks from trying to update disposed widgets

**Files Changed**:
- `lib/features/practice/presentation/screens/practice_playback_screen.dart` (lines 92-96, 153-164)

## Technical Details

### Stack Children Fix
**Before**:
```dart
children: [
  SlideTransition(...),
  if (_showMovementMap)
    Positioned(...),
]
```

**After**:
```dart
children: [
  SlideTransition(...),
  Positioned(
    child: IgnorePointer(
      ignoring: !_showMovementMap,
      child: Stack(...),
    ),
  ),
]
```

### Navigation Fix
**Before**:
```dart
Navigator.of(context).pop();  // Conflicts with GoRouter
```

**After**:
```dart
context.pop();  // Uses GoRouter's navigation
```

### Tab Switching Logic
When user taps a tab while on playback screen:
1. Detect if on `/playback` route
2. Use `popUntil()` to return to tab root
3. Call `goNamed()` to navigate to the new tab
4. Timer automatically pauses via `deactivate()`

## Testing

Run the following to verify fixes:
```bash
flutter analyze lib/  # Should show no errors
flutter pub get       # Verify dependencies
```

Test scenarios:
1. **Tab Switching**: Open practice → Start playback → Click Explore tab (should return to Practice first, then navigate)
2. **Map Toggle**: Click Map button repeatedly while switching tabs
3. **Timer**: Start timer → Click different tab → Return to tab (timer should remain paused)

## Performance Impact

- ✅ No performance regression
- ✅ Fewer widget rebuilds (fixed layout thrashing)
- ✅ Proper resource cleanup when switching tabs
- ✅ Timer properly pauses instead of continuing in background

## Related Issues

This fixes the navigation flow documented in Session 3 where PopScope cleanup was attempted but incomplete. The proper fix required coordination between GoRouter and Flutter's Navigator stack.
