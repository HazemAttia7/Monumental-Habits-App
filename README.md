# Monument 🚀

A production-scale habit-building and personal growth application built with Flutter, designed around behavioral systems, offline-first architecture, community engagement, and long-term habit consistency.

## 📖 About

Monument is a feature-rich habit builder application created to explore and implement the systems behind successful habit formation rather than simply tracking daily tasks.

The project was developed as a solo endeavor with a strong focus on scalable architecture, clean code practices, and real-world mobile development concepts. Throughout the development process, the application evolved into a complete ecosystem that combines habit tracking, analytics, educational content, social interaction, and offline-first synchronization.

One of the primary goals of the project was to deeply understand concepts such as Offline First Architecture, Real-Time Data Synchronization, Deep Linking, Local Notifications, Social Systems, and scalable state management patterns.

The application currently includes all core functionality required for daily use, while future updates will introduce monetization, activity tracking, feedback systems, and additional premium features.

---

## ✨ Features

### 🔐 Authentication & User Management

* User Registration
* Secure Login
* Google Sign-In
* Remember Me Functionality
* Password Recovery via OTP
* Email Verification
* Profile Management
* Change Username
* Change Email
* Change Password

---

### 🎯 Habit Management System

* Create New Habits
* Edit Existing Habits
* Daily Habit Tracking
* Habit Completion History
* Habit Status Management
* Monthly Calendar Tracking
* Habit Analytics Dashboard
* Habit Search

#### Analytics Included

* Current Streak
* Best Streak
* Completion Ratio
* Easiness Score
* Weekly Progress
* Monthly Progress
* Yearly Progress

---

### 🔔 Notifications & Reminders

* Local Notifications
* Custom Reminder Times
* Daily Habit Reminders
* Offline Notification Support
* Timezone-Aware Scheduling

---

### 📚 Courses System

* Browse Courses
* Course Details
* Lesson Progress Tracking
* Course Search
* Sorting & Filtering
* Popular Courses
* Locked Lesson Logic
* User Progress Synchronization
* Retry & Error Handling

---

### 👥 Community System

* Community Feed
* Create Posts
* Like Posts
* Comment System
* Replies System
* Post Details View
* Real-Time Updates Using Streams

#### Real-Time Features

* Live Likes Count
* Live Comments
* Live Replies
* Automatic UI Updates

---

### 🤝 Friends System

* Send Friend Requests
* Receive Friend Requests
* View Sent Requests
* View Received Requests
* Accept Requests
* Remove Friends
* Friends List
* User Search
* User Relationship Status

#### User Profiles

* Public User Profile
* User Statistics
* Habit Summary
* Habit Analysis

---

### 🔗 Sharing & Deep Linking

* Share Posts Outside The App
* Deep Link Navigation
* GitHub Pages Based Linking
* Open Shared Posts Directly Inside The Application

---

### 📊 Dashboard & Analytics

* Weekly Statistics
* Monthly Statistics
* Yearly Statistics
* Habit Performance Tracking
* User Progress Overview

---

### ⚙️ Settings & Support

* Notification Settings
* Habit Reminder Settings
* FAQ System
* Privacy Policy
* About Page

#### Connect Section

* LinkedIn
* GitHub
* Email

---

## 🏗️ Architecture

The project follows a scalable architecture built around MVVM principles and BLoC state management.

### Architecture Stack

* MVVM Architecture
* BLoC / Cubit State Management
* Repository Pattern
* Dependency Injection
* Offline First Design
* Separation of Concerns

### UI State Management

* Cubit for Business Logic
* ChangeNotifier Controllers for View Logic
* Provider for Controller Management

### Data Flow

```text
UI
 ↓
Cubit
 ↓
Repository
 ↓
Local Data Source (Isar)
 ↓
Remote Data Source (Firestore)
```

---

## 🌐 Offline First Architecture

One of the core pillars of Monument is Offline First Design.

### Implementation

* Local database powered by Isar
* Instant UI updates
* Automatic background synchronization
* Local-first reads
* Firestore synchronization
* Conflict resolution using Last Write Wins

### Benefits

* Works without internet
* Faster user experience
* No loading dependency
* Reliable data persistence

---

## 🛠️ Tech Stack

### Framework

* Flutter

### Architecture

* MVVM
* Repository Pattern

### State Management

* BLoC
* Cubit
* Provider
* ChangeNotifier

### Backend

* Firebase Authentication
* Cloud Firestore

### Local Storage

* Isar Database
* Shared Preferences

### Notifications

* Flutter Local Notifications

### Navigation

* Go Router

### Networking

* HTTP

### Dependency Injection

* Get It

### Deep Linking

* App Links

### Sharing

* Share Plus

### Email Services

* SendGrid
* Email OTP

---

## 📦 Main Dependencies

```yaml
flutter_bloc
provider
isar
firebase_auth
cloud_firestore
go_router
get_it
flutter_local_notifications
connectivity_plus
app_links
share_plus
email_otp
flutter_dotenv
cached_network_image
shared_preferences
```

---

## 🔒 Security Features

* Environment Variables using .env
* Protected API Keys
* Firebase Authentication
* Secure Email Verification Flow
* Secure Password Recovery

---

## 📸 Screenshots

Will be added Soon

```text
Onboarding
Authentication
Home Dashboard
Habit Tracking
Habit Analytics
Community Feed
Post Details
Friends System
Courses
Profile
Settings
Premium View
```

---

## 🚀 Getting Started

### Clone Repository

```bash
git clone https://github.com/HazemAttia7/Monumental-Habits-App.git
```

### Navigate To Project

```bash
cd Monumental-Habits-App
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## 🎯 Roadmap

### Completed

* [x] Authentication System
* [x] Habit Tracking
* [x] Habit Analytics
* [x] Offline First Architecture
* [x] Courses System
* [x] Community Feed
* [x] Real-Time Interactions
* [x] Deep Linking
* [x] Friends System
* [x] Dashboard Analytics
* [x] Local Notifications
* [x] Settings & Support

### Planned

* [ ] Activity Log
* [ ] Feedback System
* [ ] Premium Subscription Logic
* [ ] Payment Gateway Integration

---

## 👨‍💻 Development

Monument was developed as a solo project focused on mastering advanced Flutter concepts and building a real-world production-scale mobile application.

The project combines multiple complex systems including Offline First Architecture, Real-Time Communication, Deep Linking, Local Databases, Authentication, Analytics, and Social Features within a single cohesive ecosystem.

### Development Stats

* Total Work Hours: 154.19 Hours
* Contributors: 1 (Solo Project)
* Architecture: MVVM + BLoC
* Status: Active Development
* Platforms: Android & iOS

---

## 🌟 Key Concepts Implemented

* Offline First Architecture
* Repository Pattern
* MVVM Architecture
* BLoC State Management
* Local Notifications
* Deep Linking
* Real-Time Streams
* Conflict Resolution
* Optimistic UI Updates
* Dependency Injection
* Search, Filter & Sorting Systems
* Social Interactions
* User Analytics

---

Built with ❤️ using Flutter.
