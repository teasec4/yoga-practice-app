# Yoga Coach - Product Overview

## Mission
A Flutter yoga app that empowers users to practice yoga through interactive lessons, build custom routines, and progress through a gamified achievement system.

---

## Core Product

### 🧘 Three Main Tabs

#### 1. **Practice** 
The core learning experience
- **Default Practices**: 10 curated yoga routines (Beginner → Intermediate → Advanced)
- **My Practices**: User-created custom routines
  - Add button: Create custom lessons
  - Drag-and-drop pose sequencing (planned)
- **Playback Screen**:
  - Full-screen card interface per movement
  - Built-in timer with progress bar
  - Movement map (grid view of all poses)
  - Navigation: Next/Done buttons
  - Smooth fadeout close animation

#### 2. **Explore**
Discover and download new workouts
- **Popular Section**: Trending workouts (3 visible + Look More)
- **Newest Section**: Latest additions (3 visible + Look More)
- **Future**: Download & install functionality
- **Blocked**: Behind level/achievement requirements (planned)

#### 3. **Me**
Gamified user profile & progression
- **Profile Card**:
  - User avatar
  - Level badge with XP bar
  - Streak counter
  - Total practice hours
- **Achievements**:
  - Locked/Unlocked badges
  - Progress indicators
  - Unlock conditions
- **Statistics**:
  - Lessons completed
  - Total duration
  - Average session time
  - Favorite poses
- **Settings**:
  - Notifications preferences
  - Account management
  - App info

---

## Key Features

### Gamification System
- **Level Progression**: 1-10 levels
- **XP System**: Earn XP for completed sessions
- **Streaks**: Daily practice tracking
- **Achievements**: 12+ unlockable badges
  - First Steps (complete 1 practice)
  - Consistent (7-day streak)
  - Zen Master (100 total hours)
  - Power Yogi (advanced practices)
  - Community Helper (share practices)
  - Leaderboard Champion (top 10)

### Practice Management
- **Create Custom Lessons**:
  - Name & description
  - Difficulty selector
  - Icon picker
  - Pose library (selection UI)
  - Auto-duration calculation
- **Organize**:
  - Favorites system
  - Sort by difficulty/duration
  - Pinned favorites
  - Draft saves

### Timer & Tracking
- **Built-in Timer**:
  - Per-pose duration
  - Progress bar visualization
  - Pause/Resume
  - Visual completion feedback
- **Session Tracking**:
  - Completion tracking
  - Time tracking
  - Streak maintenance
  - Historical data

### Explore & Discovery
- **Downloadable Content**:
  - Browse popular workouts
  - View newest additions
  - Filter by difficulty/duration
  - Preview before download
- **Community Features**:
  - Share custom practices
  - Download community practices
  - Rate & review
  - Comments section

---

## Monetization Strategy

### Free Model (Current)
- All core features free
- Ad integration (planned):
  - Banner ads on list screens
  - Interstitial ads between playback
  - Rewarded ads for hints (planned)

### Future: Premium
- Ad-free experience
- Advanced personalization
- Priority community features
- Early access to new content

---

## User Progression System

### Level Unlocking
| Level | XP Required | Unlock |
|-------|-------------|--------|
| 1 | 0 | Access default practices |
| 2 | 50 | Create custom practices |
| 3 | 150 | Access intermediate |
| 4 | 300 | Access advanced |
| 5 | 500 | Download community workouts |
| 6 | 750 | Create public practices |
| 7 | 1000 | Access power challenges |
| 8 | 1300 | Unlock all icons |
| 9 | 1600 | VIP features (planned) |
| 10 | 2000 | Legendary status |

---

## Target Users

### Primary
- **Yoga Enthusiasts**: 18-50 years old, want structured learning
- **Beginners**: Want safe, no-cost practice with progression
- **Home Practitioners**: Prefer app-based guidance
- **Fitness Gamers**: Love achievement systems & progression

### Secondary
- **Yoga Teachers**: Want community sharing & student tracking
- **Wellness Apps Users**: Cross-appeal from habit trackers
- **Meditation App Users**: Natural expansion audience

---

## Competitive Advantages

1. **Custom Lesson Creation**: Build & share personalized routines
2. **Gamification**: Achievement system keeps users engaged
3. **Offline-First**: Works without internet (planned)
4. **No Subscription**: Free experience with premium option
5. **Community**: Share & discover user-created content
6. **Local Progress**: All data on device initially, sync optional

---

## Technical Stack

### Frontend
- **Framework**: Flutter 3.27+
- **Navigation**: go_router 14.2+
- **Theme**: Material Design 3
- **Typography**: Poppins (Google Fonts)

### Architecture
- **Pattern**: Clean Architecture (Domain/Data/Presentation)
- **Structure**: Feature-based folders
- **State Management**: Riverpod (planned)
- **Database**: SQLite (local), Firebase (sync, planned)

### Future Backend
- **Auth**: Firebase Authentication
- **Database**: Cloud Firestore
- **Storage**: Firebase Storage (video/images)
- **Analytics**: Firebase Analytics
- **Push Notifications**: Firebase Cloud Messaging

---

## Roadmap

### Phase 1 (MVP) ✅
- Core navigation & Practice screen
- Playback with timer
- Basic settings
- Theme system

### Phase 2 (Current) 🔄
- Me tab with gamification
- Practice creation UI
- Explore expansion
- Feature blocking system

### Phase 3 (Next)
- State management cleanup
- Local database setup
- Offline functionality
- Performance optimization

### Phase 4
- Firebase integration
- User authentication
- Cloud sync
- Leaderboards

### Phase 5
- Community features
- Video support
- Social sharing
- Premium tier

### Phase 6
- Analytics
- A/B testing
- Personalization
- App store optimization

---

## Success Metrics

### Engagement
- DAU (Daily Active Users)
- Session length
- Streak maintenance
- Feature adoption

### Retention
- Day-7 retention
- Day-30 retention
- Churn rate
- Monthly active users

### Growth
- Download velocity
- User acquisition cost
- Organic growth %
- Referral rate

---

## Design Philosophy

### Visual
- Clean, minimalist UI
- Yoga-inspired color palette
- Soft, calming aesthetics
- Consistent spacing & typography

### UX
- Instant feedback (no delays)
- Clear progression indicators
- Celebration moments (achievements)
- Frictionless onboarding

### Content
- Quality over quantity (10 curated practices)
- Progressive difficulty
- Clear movement instructions
- Encouraging feedback

---

## Legal & Compliance

### Disclaimers
- Not medical advice
- User accepts responsibility
- Encourage proper form
- Modification options always available

### Privacy
- No unnecessary data collection
- Optional cloud features
- User data ownership
- Transparent data usage

### Accessibility
- WCAG 2.1 AA compliance (planned)
- Text alternatives for icons
- High contrast modes
- Screen reader support

---

## Future Expansion

### Content
- Video demonstrations (instead of text)
- Audio guidance & music
- Multilingual support
- Niche programs (pregnancy, seniors, athletes)

### Features
- Live classes with instructors
- Personalized recommendations
- Wearable integration
- Social challenges

### Monetization
- Premium instructor content
- Branded yoga products
- Affiliate partnerships
- B2B (corporate wellness)

---

**Last Updated**: Dec 29, 2025  
**Version**: 0.2 (Post-Playback)  
**Status**: 🟢 On Track for Feature Complete by 2026
