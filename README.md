# FIRGO - Pakistan's Premium Ride-Sharing Platform

![FIRGO Logo](assets/images/firgo_logo.png)

## 📱 Overview

FIRGO is a modern, feature-rich Flutter-based ride-sharing application designed specifically for Pakistan. It provides a seamless experience for both passengers and drivers with real-time location tracking, secure payments, and professional UI.

## ✨ Features

### Passenger Features
- 🔐 Secure authentication (Email/Password)
- 📍 Real-time location tracking
- 🚗 Multiple ride types (Economy, Premium, Shared)
- 💰 Transparent fare calculation
- 🔔 Real-time ride notifications
- ⭐ Rating system for drivers
- 📊 Ride history and analytics
- 💳 Multiple payment methods (Card, JazzCash, etc.)
- 🆘 SOS emergency feature

### Driver Features
- 👨‍✈️ Simple driver registration with verification
- 🗺️ Real-time ride requests
- 📍 Live GPS tracking
- 💵 Real-time earnings dashboard
- 📈 Weekly earnings analytics
- 🏦 Multiple withdrawal options
- ⭐ Rating system from passengers
- 📱 Push notifications

### General Features
- 🌙 Dark/Light theme support
- 🌍 Multilingual support (Urdu/English)
- 🔒 End-to-end encryption
- 📡 Offline mode
- ⚡ Firebase integration
- 🔄 Real-time database sync

## 🏗️ Architecture

FIRGO follows a clean, scalable architecture:

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
│   ├── user_model.dart
│   └── ride_model.dart
├── providers/                # State management (Provider)
│   ├── auth_provider.dart
│   ├── location_provider.dart
│   └── ride_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── passenger/
│   │   ├── passenger_home_screen.dart
│   │   ├── ride_request_screen.dart
│   │   ├── ride_details_screen.dart
│   │   └── ride_history_screen.dart
│   └── driver/
│       ├── driver_home_screen.dart
│       ├── available_rides_screen.dart
│       └── driver_earnings_screen.dart
├── theme/                    # App theming
│   └── app_theme.dart
└── utils/                    # Utilities
    ├── api_endpoints.dart
    ├── app_constants.dart
    ├── dialog_helper.dart
    ├── string_extensions.dart
    └── number_extensions.dart
```

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **UI Components**: Material Design 3

### Backend & Services
- **Backend**: Firebase (Cloud Firestore)
- **Authentication**: Firebase Auth
- **Real-time Database**: Firebase Realtime Database
- **Storage**: Firebase Storage
- **Cloud Messaging**: Firebase Cloud Messaging
- **Maps**: Google Maps API
- **Location**: Geolocator
- **Payments**: Razorpay, Stripe

### Key Dependencies
```yaml
firebase_core: ^2.24.0
firebase_auth: ^4.15.0
cloud_firestore: ^4.13.0
provider: ^6.2.0
google_maps_flutter: ^2.5.0
geolocator: ^10.1.0
razorpay_flutter: ^1.3.6
firebase_messaging: ^14.7.0
```

## 📋 Requirements

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android SDK Level 21+
- iOS 11.0+
- Firebase Project

## 🚀 Getting Started

### 1. Prerequisites
```bash
# Install Flutter
flutter --version  # Ensure >= 3.0.0

# Verify dependencies
flutter doctor
```

### 2. Clone Repository
```bash
git clone https://github.com/faheemraog947-cmyk/FIRGO.git
cd FIRGO
```

### 3. Setup Firebase
- Create a Firebase project at https://console.firebase.google.com
- Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
- Place them in appropriate directories
- Update Firebase configuration in `lib/firebase_options.dart`

### 4. Install Dependencies
```bash
flutter pub get
```

### 5. Configure Platform-Specific Settings

#### Android
```bash
cd android
# Configure signing keys in build.gradle
```

#### iOS
```bash
cd ios
pod install
pod repo update
```

### 6. Run Application
```bash
# Development
flutter run

# Release (Android)
flutter build apk --release

# Release (iOS)
flutter build ipa --release
```

## 📱 Configuration

### Environment Variables
Create `.env` file in project root:
```env
FIREBASE_PROJECT_ID=your-project-id
GOOGLE_MAPS_API_KEY=your-api-key
RAZORPAY_KEY=your-key
STRIPE_KEY=your-key
```

### Firebase Setup
1. Enable Authentication methods (Email/Password)
2. Create Firestore collections:
   - `users`
   - `rides`
   - `payments`
   - `drivers`

3. Set up security rules
4. Enable Firebase Storage for documents

## 📚 API Integration

### Authentication Flow
```
User Input → Auth Provider → Firebase Auth → Firestore (User Data)
```

### Ride Flow
```
Ride Request → Ride Provider → Firestore → Driver Notification → Accept/Reject
```

### Location Flow
```
Geolocator → Location Provider → Real-time Updates → UI
```

## 🔐 Security Features

- Firebase Authentication with email verification
- Encrypted payment information
- Role-based access control (Passenger/Driver)
- Secure communication with HTTPS
- Data validation on client & server side
- Firebase Security Rules for database access

## 📊 Project Structure

### Models (Data Layer)
- `UserModel`: User profile, ratings, preferences
- `RideModel`: Ride details, pricing, status tracking

### Providers (Business Logic)
- `AuthProvider`: User authentication & profile management
- `LocationProvider`: GPS tracking & geocoding
- `RideProvider`: Ride operations & history

### Screens (UI Layer)
- Modular, reusable components
- Responsive design for different screen sizes
- Dark theme support

## 🎨 UI/UX

- Material Design 3 compliance
- Consistent color scheme (Primary: #1E3A8A, Secondary: #FF6B35)
- Smooth animations and transitions
- Responsive layouts
- Accessibility support

## 🧪 Testing

### Unit Tests
```bash
flutter test test/
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📈 Performance Optimization

- Image caching with cached_network_image
- Lazy loading for lists
- Efficient state management with Provider
- Optimized Firebase queries with indexes

## 🐛 Troubleshooting

### Common Issues

1. **Firebase Connection Failed**
   - Verify internet connection
   - Check Firebase credentials
   - Review Firebase security rules

2. **Location Permission Denied**
   - Grant location permission in app settings
   - Check platform-specific permissions

3. **Map Not Loading**
   - Verify Google Maps API key
   - Check API quota limits
   - Enable Maps API in Google Cloud Console

## 📝 Development Guidelines

### Code Style
- Follow Dart conventions
- Use meaningful variable names
- Add comments for complex logic
- Keep methods small and focused

### Git Workflow
```bash
# Feature branch
git checkout -b feature/feature-name
git commit -m "feat: Add feature description"
git push origin feature/feature-name

# Create Pull Request
```

## 🚀 Deployment

### Android
```bash
flutter build appbundle --release
# Upload to Google Play Console
```

### iOS
```bash
flutter build ipa --release
# Upload to TestFlight/App Store
```

## 📞 Support & Contribution

### Report Issues
Create an issue on GitHub with:
- Detailed description
- Steps to reproduce
- Expected vs actual behavior
- Device/OS information

### Contributing
1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## 📄 License

MIT License - see LICENSE file for details

## 👥 Team

- **Faheem Raogh** - Lead Developer
- FIRGO Development Team

## 🙏 Acknowledgments

- Flutter & Dart teams
- Firebase team
- Material Design team
- Community contributors

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)

## 🔮 Future Enhancements

- [ ] Video call support for driver-passenger communication
- [ ] AI-powered route optimization
- [ ] Loyalty rewards program
- [ ] Corporate account management
- [ ] Advanced analytics dashboard
- [ ] Multi-language support (8+ languages)
- [ ] Accessibility improvements (WAI-ARIA)
- [ ] Offline mode enhancements
- [ ] IoT vehicle integration
- [ ] Blockchain-based rating system

---

**Made with ❤️ in Pakistan**

For more information, visit: [FIRGO Official Website](https://firgo.app)
