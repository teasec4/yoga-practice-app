# 🧘 Yoga Coach

A Flutter yoga app that empowers users to practice yoga through interactive lessons, build custom routines, and progress through a gamified achievement system.

## 📋 Features

### 🎯 Core Tabs
- **Practice** - Curated yoga lessons with full-screen playback and movement tracking
- **Explore** - Discover and browse popular and newest workouts  
- **Me** - User profile with gamification and achievements (coming soon)

### 🎮 Current Playback Features
- Full-screen movement cards with descriptions
- Movement map grid view (tap to select)
- Next/Done navigation
- Back button returns to detail screen
- Instant navigation (no animations)

## 🚀 Quick Start

```bash
# Get dependencies
flutter pub get

# Run on emulator/device
flutter run

# Analyze code
flutter analyze
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   └── routes/
│       ├── app_routes.dart   # GoRouter configuration
│       ├── main_shell.dart   # Bottom navigation shell
│       └── transitions.dart   # Page transitions
├── features/
│   ├── practice/
│   │   ├── domain/entities/
│   │   ├── data/models/
│   │   └── presentation/screens & widgets/
│   ├── statistics/           # (Renamed to Explore)
│   ├── me/                   # User profile & settings
│   └── settings/
└── core/
    └── theme/                # Light & Dark themes
```

## 🎨 Design System

### Colors
- **Primary**: #9B7FB3 (Light) / #7B5FA3 (Dark)
- **Secondary**: #8BC98D (Light) / #6BA86D (Dark)
- **Accent**: #ADD4E0 (Light) / #8FB3C5 (Dark)

### Typography
- Font: Poppins (Google Fonts)
- Headline Large: 32px, Weight 700
- Body Medium: 14px, Weight 400

## 🔧 Technology Stack

- **Framework**: Flutter 3.10+
- **Navigation**: GoRouter 14.6+
- **Architecture**: Clean Architecture with feature-based organization
- **UI**: Material Design 3

## 📊 Current Progress

| Area | Status | Notes |
|------|--------|-------|
| Navigation | ✅ Complete | Tab switching with GoRouter |
| Practice Playback | ✅ Complete | Full-screen cards with timer |
| Explore Tab | ✅ Complete | Popular & Newest sections |
| Me Tab | 🔄 In Progress | Gamification features planned |
| Practice Creation | 📋 Planned | Add custom lesson form |
| Data Persistence | 📋 Planned | SQLite integration |
| Authentication | 📋 Planned | Firebase Auth |

## 📝 Documentation

**Quick Start** (choose one):
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - One-page cheat sheet (2 min) ⭐
- [docs/INDEX.md](docs/INDEX.md) - Master guide to all documentation ⭐

**For Developers**:
- [docs/GETTING_STARTED_DEV.md](docs/GETTING_STARTED_DEV.md) - Onboarding guide
- [docs/ROUTING_GUIDE.md](docs/ROUTING_GUIDE.md) - Navigation patterns
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) - App structure

**For Details**:
- [docs/SESSION_4_COMPLETE.md](docs/SESSION_4_COMPLETE.md) - Session summary
- [CHANGELOG_SESSION_4.md](CHANGELOG_SESSION_4.md) - What changed
- [docs/DEVELOPMENT_PROGRESS.md](docs/DEVELOPMENT_PROGRESS.md) - Feature timeline
- [docs/product.md](docs/product.md) - Product vision
- [docs/tech.md](docs/tech.md) - Technology stack

## 🐛 Known Issues Fixed (Session 4)

- ✅ GlobalKey layout errors resolved
- ✅ Tab switching now works from playback screen
- ✅ Timer properly pauses when switching tabs
- ✅ Movement map modal no longer causes layout thrashing

## 🎯 Next Phase

1. **High Priority**: Me tab with gamification
2. **High Priority**: Practice creation UI with lesson builder
3. **Medium Priority**: Feature blocking system
4. **Medium Priority**: Explore expansion with search

## 📱 Supported Platforms

- ✅ iOS (11.0+)
- ✅ Android (API 21+)
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 📄 License

This project is open source and available under the MIT License.

---

**Last Updated**: Dec 30, 2025  
**Version**: 0.3 (Navigation Fixes)  
**Status**: 🟢 Stable
