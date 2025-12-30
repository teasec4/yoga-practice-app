# Quick Reference - Yoga Coach Navigation & Architecture

## 🎯 3-Tab Structure

```
┌─────────────────────────────────────────────────┐
│  YOGA COACH APP                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│           [Your Screen Content]                 │
│                                                 │
├─────────────────────────────────────────────────┤
│  [Practice]  [Explore]  [Me]                    │
└─────────────────────────────────────────────────┘
```

## 📍 Route Map

```
/practice                    /statistics              /me
├─ PracticeScreen           └─ StatisticsScreen      └─ MeScreen
│  (list view)                (popular + newest)        (profile)
│
├─ /:id
│  PracticeDetailScreen
│  (info + start button)
│
├─ /:id/playback
│  PracticePlaybackScreen
│  (movement cards + map)
│
└─ /custom/:id          ← NEW!
   CustomPracticeDetailScreen
   (user-created routine)
```

## 🔀 Navigation Cheat Sheet

### Tab Switching (from any screen)
```dart
context.goNamed('practice');      // Tab 1
context.goNamed('statistics');    // Tab 2
context.goNamed('me');            // Tab 3
```

### Within Practice Tab
```dart
// Go to standard practice detail
context.go('/practice/$practiceId');

// Go to custom practice detail (NEW)
context.go('/practice/custom/$practiceId');

// Go to playback (from detail)
context.push('/practice/$practiceId/playback');

// Go back one screen
Navigator.of(context).pop();
```

## 🔧 Files to Edit

### Add New Tab
1. Create `features/my_feature/presentation/screens/my_screen.dart`
2. Add route to `app_routes.dart`
3. Add tab to `main_shell.dart`

### Change Tab Layout
- Edit: `lib/app/routes/main_shell.dart`

### Add Nested Route
- Edit: `lib/app/routes/app_routes.dart`
- Nest under existing route

### Update Playback
- Edit: `lib/features/practice/presentation/screens/practice_playback_screen.dart`

## 📊 Code Metrics

| Metric | Current |
|--------|---------|
| Animation Controllers | 0 |
| Dart Files | 21 |
| Routes | 6 main + nested |
| Screens | 7 |
| Total Lines | ~3800 |
| Custom Features | 1 (custom practices) |

## ✅ Navigation Checklist

- [x] No animations (instant navigation)
- [x] Bottom nav persists
- [x] Tab switching resets nested routes
- [x] Back button works
- [x] No layout errors
- [x] No routing loops

## 🚀 Common Tasks

### Run App
```bash
flutter run
```

### Check Errors
```bash
flutter analyze lib/
```

### Format Code
```bash
flutter format lib/
```

### Get Dependencies
```bash
flutter pub get
```

### Build APK
```bash
flutter build apk --release
```

## 📁 Key Files

```
app_routes.dart        ← All routes defined here
main_shell.dart        ← Bottom navigation bar
practice_playback_screen.dart  ← Movement playback UI
practice_detail_screen.dart    ← Lesson info
```

## 🎨 Theme Colors

```
Primary:    #9B7FB3 (light) / #7B5FA3 (dark)
Secondary:  #8BC98D (light) / #6BA86D (dark)
Accent:     #ADD4E0 (light) / #8FB3C5 (dark)
Custom:     Colors.purple (custom practices)
```

## ✨ Custom Practices (NEW)

**Feature**: Create personalized yoga routines  
**Access**: Tap "+" button on Practice tab  
**Selection**: Apple-style (tap in order)  
**Default**: 1 minute per pose  
**View**: Detail screen shows poses in order  
**Storage**: In-memory (persistence coming v1.1)

## 💡 Pro Tips

1. **Don't mix Navigator + GoRouter**: Use one consistently
2. **Use goNamed() for tabs**: Automatically resets nested routes
3. **Use Navigator.pop() for nested**: Respects GoRouter stack
4. **Keep animations minimal**: They add bugs, not UX
5. **Use const where possible**: Improves performance

---

**Last Updated**: Dec 30, 2025  
**Tip**: See `docs/` folder for detailed guides
