# Getting Started - For Developers

New to this project? Start here!

## 🚀 Step 1: Setup (5 minutes)

```bash
# Get the code
git clone <repo>
cd yoga-practice-app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## 📖 Step 2: Learn (15 minutes)

Read these in order:

1. **QUICK_REFERENCE.md** (2 min)
   - What is the app?
   - How does navigation work?

2. **docs/ROUTING_GUIDE.md** (5 min)
   - Navigation patterns
   - Route structure
   - Examples

3. **docs/ARCHITECTURE.md** (8 min)
   - Folder structure
   - Layers (domain/data/presentation)
   - How to add features

## 🎯 Step 3: Key Files (5 minutes)

Important files to know:

```
lib/app/routes/
  ├── app_routes.dart        ← All routes defined here
  └── main_shell.dart        ← Bottom navigation bar

lib/features/
  ├── practice/              ← Practice lessons
  │   ├── domain/entities/
  │   ├── data/models/
  │   └── presentation/
  ├── statistics/            ← Explore/discover
  └── me/                    ← User profile (planned)

docs/
  ├── ROUTING_GUIDE.md       ← How to navigate
  ├── ARCHITECTURE.md        ← App structure
  └── SESSION_4_COMPLETE.md  ← What's new
```

## 💻 Step 4: Try Something (10 minutes)

### Task 1: Navigate to a practice
1. Run the app
2. Click a practice in the list
3. Click "Start Practice"
4. Click "NEXT" to see next movement
5. Click "X" to go back

**What you learned**: Navigation works!

### Task 2: Check the code flow
1. Open `lib/features/practice/presentation/screens/practice_screen.dart`
2. See: `context.go('/practice/${practice.id}')` → This navigates to detail
3. Open `lib/features/practice/presentation/screens/practice_detail_screen.dart`
4. See: `context.push('/practice/${practice.id}/playback')` → This navigates to playback

**What you learned**: How navigation works!

### Task 3: Add a simple feature
1. Open `lib/features/practice/presentation/screens/practice_playback_screen.dart`
2. Find: `class PracticePlaybackScreen`
3. Find: `void _nextCard()` method
4. Add: `print('Moving to card ${_currentCardIndex}');` before setState
5. Run app and check console

**What you learned**: How to modify code!

## 🏗️ Step 5: Understand Architecture (10 minutes)

This app uses **Clean Architecture**:

```
Practice Feature
├── Domain (Business Logic)
│   └── entities/
│       └── practice.dart      ← What is a Practice?
│
├── Data (External Data)
│   └── models/
│       └── practice_model.dart ← Where do we get practices?
│
└── Presentation (UI)
    ├── screens/
    │   ├── practice_screen.dart          ← List view
    │   ├── practice_detail_screen.dart   ← Detail view
    │   └── practice_playback_screen.dart ← Playback view
    └── widgets/
        └── practice_tile.dart           ← List item widget
```

**Key idea**: Each layer has one job:
- Domain: Define what a practice is
- Data: Get practice data
- Presentation: Show practices to user

## 🧭 Step 6: Navigation (10 minutes)

This app has **3 main routes**:

```
/practice       ← Practice tab (list of workouts)
/statistics     ← Explore tab (popular & newest)
/me             ← Me tab (profile & achievements)
```

Each can have **sub-routes**:

```
/practice/:id          ← Detail screen for one practice
/practice/:id/playback ← Playback screen for movements
```

**Navigation APIs**:
```dart
// Switch tabs
context.goNamed('practice');       // Go to practice tab

// Go to detail screen
context.go('/practice/$id');       // Navigate to detail

// Go to playback (from detail)
context.push('/practice/$id/playback');  // Push to stack

// Go back one screen
Navigator.of(context).pop();       // Pop from stack
```

## 🎓 Step 7: Common Tasks

### Add a new screen
1. Create file: `lib/features/myfeature/presentation/screens/my_screen.dart`
2. Create widget: `class MyScreen extends StatelessWidget { ... }`
3. Add to routes: Edit `lib/app/routes/app_routes.dart`
4. Add navigation: Use `context.goNamed('myfeature')`

### Add a button click handler
1. Find the button widget
2. Add `onPressed: () { ... }`
3. Use navigation: `context.go('/path')`

### Change the practice list
1. Edit: `lib/features/practice/data/models/practice_model.dart`
2. Modify: `final mockPractices = [ ... ]`

### Change colors
1. Edit: `lib/core/theme/app_theme.dart`
2. Modify: `colorScheme: ColorScheme(...)`

## 🐛 Step 8: Common Issues

### "Widget not found"
- Check import statements at top of file
- Make sure file path is correct

### "Route not found"
- Check `app_routes.dart` for typos
- Make sure route name matches

### "Build error"
- Run: `flutter clean`
- Run: `flutter pub get`
- Run: `flutter run`

### "Layout overflow"
- Check widget constraints
- Use `Expanded` or `Flexible` for flexible sizing
- Look for `SingleChildScrollView` if content overflows

## 📚 Step 9: Documentation

When you need to know something:

| Question | Read |
|----------|------|
| How do I navigate? | docs/ROUTING_GUIDE.md |
| What's the app structure? | docs/ARCHITECTURE.md |
| How do I add a feature? | docs/ARCHITECTURE.md → "Feature Addition Checklist" |
| What changed recently? | CHANGELOG_SESSION_4.md |
| Quick reference? | QUICK_REFERENCE.md |

## ✅ Step 10: Next

You're ready to:
- ✅ Understand the codebase
- ✅ Navigate the app
- ✅ Read and modify code
- ✅ Add simple features

**Next level**: 
- Add timer functionality
- Implement Me tab
- Create practice form

---

## 🎯 Quick Start Commands

```bash
# Run app
flutter run

# Check for errors
flutter analyze lib/

# Format code
flutter format lib/

# Get dependencies
flutter pub get

# Run tests
flutter test

# Build APK (Android)
flutter build apk --release

# Build iOS
flutter build ios --release
```

---

## 💡 Tips

1. **Use search**: Ctrl+Shift+F to find text in code
2. **Follow imports**: Ctrl+click on import to see files
3. **Check type errors**: `flutter analyze` before running
4. **Test navigation**: Make sure back button works
5. **Keep it simple**: Remove code you don't need

---

## 🚀 Ready to Code?

Start with:
1. Read QUICK_REFERENCE.md (2 min)
2. Read docs/ROUTING_GUIDE.md (5 min)
3. Open `practice_screen.dart` and understand the code
4. Try the tasks in "Step 4"
5. Make your first change!

---

**Need help?** Check docs/ folder for detailed guides.

**Found a bug?** See "Step 8: Common Issues"

**Want to add a feature?** See docs/ARCHITECTURE.md → Feature Addition Checklist

---

**Happy coding! 🎉**

