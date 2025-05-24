# Japfa Feed Application

A Flutter-based mobile app built for managing feed orders and logistics at Japfa. This project is built for both Android and iOS platforms.

## 🚀 Features

- User Login & Authentication
- Firebase Integration (Push Notifications, Analytics)
- Background Tasks using WorkManager
- Offline Support
- Multi-platform: Android & iOS

## 🛠️ Getting Started

These instructions will get your copy of the project up and running on your local machine for development and testing.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio / Xcode
- Firebase Project (You need to add your own `google-services.json` and `GoogleService-Info.plist`)
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/japfa_feed_application3.git
cd japfa_feed_application3

# Get Flutter dependencies
flutter pub get

# Generate files if necessary
flutter pub run build_runner build

# For iOS
cd ios
pod install
cd ..

# Run on Android
flutter run

# Run on iOS
open ios/Runner.xcworkspace
# Then build via Xcode or run
flutter run

