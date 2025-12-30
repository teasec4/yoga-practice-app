# Routing Architecture Guide

## Overview

The app uses GoRouter for declarative, type-safe navigation with a simple 3-tab structure powered by ShellRoute.

## Route Structure

```
/
├── /practice (Practice Tab)
│   ├── / (PracticeScreen - list of practices)
│   ├── /:id (PracticeDetailScreen - single practice info)
│   └── /:id/playback (PracticePlaybackScreen - playback interface)
│
├── /statistics (Explore Tab)
│   └── / (StatisticsScreen - popular & newest workouts)
│
└── /me (Me Tab)
    └── / (MeScreen - user profile & achievements)
```

## Key Components

### MainShell
- **File**: `lib/app/routes/main_shell.dart`
- **Purpose**: Wraps all routes with persistent bottom navigation bar
- **Logic**: Simple tab detection based on route path + goNamed() calls
- **No complex state**: Tabs are determined by current location, not tracking

### GoRouter Configuration
- **File**: `lib/app/routes/app_routes.dart`
- **Pages**: All use `NoTransitionPage` for instant navigation
- **Nesting**: Practice routes are nested under practice tab
- **Type-safe**: Named routes with goNamed()

## Navigation Flows

### Practice Tab Navigation

#### 1. View Practice List → Detail Screen
```dart
// From practice_screen.dart
context.go('/practice/${practice.id}');
// OR using named route:
context.goNamed('practiceDetail', pathParameters: {'id': practice.id});
```

#### 2. Detail Screen → Playback Screen
```dart
// From practice_detail_screen.dart
context.push('/practice/${practice.id}/playback');
// OR:
context.pushNamed('practicePlayback', pathParameters: {'id': practice.id});
```

#### 3. Playback → Back to Detail (Close Button)
```dart
// From practice_playback_screen.dart
Navigator.of(context).pop();
// Returns to previous route in stack
```

#### 4. Switch Tab While in Playback
```dart
// From main_shell.dart (bottom nav click)
context.goNamed('statistics'); // or 'me', 'practice'
// GoRouter automatically cleans up nested routes
```

### Tab Switching Behavior

When user clicks bottom tab:
1. **From /practice**: Stays on current practice flow
2. **From /practice/:id**: Resets to /practice root
3. **From /practice/:id/playback**: 
   - `goNamed()` resets entire practice tab
   - Playback screen is popped automatically
   - Returns to Practice list view

## Why This Works

### No Manual Stack Management
- GoRouter handles the navigation stack automatically
- No need for popUntil() or complex pop logic
- Tab switching uses `goNamed()` which resets the tab root

### Clean Separation
- Each tab is independent
- Detail and playback screens are nested only under practice
- Bottom bar always visible (ShellRoute)

### Instant Navigation
- `NoTransitionPage` means no animations
- Fast response to user taps
- Smoother UX for mobile

## Common Patterns

### Navigate to a Different Tab
```dart
context.goNamed('statistics');  // Switch to Explore tab
```

### Navigate Within Same Tab
```dart
context.go('/practice/${practiceId}');  // Go to detail (nested)
context.push('/practice/${practiceId}/playback');  // Go to playback
```

### Go Back to Previous Screen
```dart
Navigator.of(context).pop();  // Pop current page
```

### Replace Current Screen
```dart
context.replace('/practice/${practiceId}');  // Replace with detail
```

## State Preservation

Currently, state is **not preserved** when switching tabs:
- Each tab resets to root when you click it
- Future: Can use GoRouter's state preservation features if needed

## Troubleshooting

### Empty Screen After Close
- ✅ **Fixed**: Use `Navigator.of(context).pop()` not `context.pop()`
- Navigator respects the GoRouter stack

### Can't Switch Tabs from Nested Route
- ✅ **Fixed**: Use `context.goNamed()` which handles tab resets

### Layout Errors with Modal
- ✅ **Fixed**: Use simple `if (_show)` in build(), not in Stack children

## Future Improvements

1. **State Caching**: Keep tab state when switching (go_router supports this)
2. **Deep Linking**: Add custom logic to handle app links like `/practice/5/playback`
3. **Splash Transitions**: Re-add animations if needed (use transitionsBuilder)
4. **Modal Routes**: Explore using showModalBottomSheet for movement grid

---

**Last Updated**: Dec 30, 2025  
**Architecture**: Clean + Feature-based + GoRouter  
**Complexity**: Simple (minimal state management)
