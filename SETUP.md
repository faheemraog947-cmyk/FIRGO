# FIRGO - Pakistan's Premium Ride-Sharing Platform

## Project Setup Instructions

### Prerequisites
- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Firebase Project
- Google Maps API Key
- Razorpay/Stripe API Keys

### Step 1: Clone Repository
```bash
git clone https://github.com/faheemraog947-cmyk/FIRGO.git
cd FIRGO
```

### Step 2: Get Dependencies
```bash
flutter pub get
```

### Step 3: Setup Firebase

#### Android Setup
1. Go to Firebase Console
2. Create new project
3. Add Android app
4. Download `google-services.json`
5. Place in `android/app/`

#### iOS Setup
1. Add iOS app in Firebase Console
2. Download `GoogleService-Info.plist`
3. Place in `ios/Runner/`
4. Open Xcode and add to Runner project

### Step 4: Configure API Keys
Update `lib/firebase_options.dart` with your Firebase credentials

### Step 5: Run App
```bash
# Debug mode
flutter run

# Release mode (Android)
flutter build apk --release

# Release mode (iOS)
flutter build ipa --release
```

## Project Status

✅ **Completed Features:**
- Authentication (Login/Signup)
- User & Ride Models
- State Management (Provider)
- Passenger Home Screen
- Ride Request & Booking
- Ride History
- Driver Home Screen
- Available Rides
- Earnings Dashboard
- Theme System
- Utilities & Extensions

## File Structure

```
FIRGO/
├── lib/
│   ├── main.dart
│   ├── firebase_options.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   └── ride_model.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── location_provider.dart
│   │   └── ride_provider.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── auth/
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   ├── passenger/
│   │   │   ├── passenger_home_screen.dart
│   │   │   ├── ride_request_screen.dart
│   │   │   ├── ride_details_screen.dart
│   │   │   └── ride_history_screen.dart
│   │   └── driver/
│   │       ├── driver_home_screen.dart
│   │       ├── available_rides_screen.dart
│   │       └── driver_earnings_screen.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       ├── api_endpoints.dart
│       ├── app_constants.dart
│       ├── dialog_helper.dart
│       ├── string_extensions.dart
│       └── number_extensions.dart
├── pubspec.yaml
├── README.md
└── .gitignore
```

## Key Dependencies

- **firebase_core**: ^2.24.0
- **firebase_auth**: ^4.15.0
- **cloud_firestore**: ^4.13.0
- **firebase_storage**: ^11.5.0
- **provider**: ^6.2.0
- **google_maps_flutter**: ^2.5.0
- **geolocator**: ^10.1.0
- **geocoding**: ^2.1.0
- **razorpay_flutter**: ^1.3.6
- **stripe_flutter**: ^10.0.0

## Development Tips

### Hot Reload
```bash
flutter run -v
```

### Build APK
```bash
flutter build apk --split-per-abi
```

### Build iOS
```bash
flutter build ios --release
```

### Clean Build
```bash
flutter clean
flutter pub get
flutter run
```

## Troubleshooting

### Firebase Connection Issues
- Verify internet connection
- Check Firebase console for errors
- Ensure security rules are properly configured

### Map Not Loading
- Verify Google Maps API key is correct
- Enable Maps API in Google Cloud Console
- Check for quota limits

### Permission Errors
- Grant required permissions in app settings
- Check AndroidManifest.xml and Info.plist

## Commits Made

1. ✅ `feat: Initialize FIRGO project structure with core dependencies and models`
2. ✅ `feat: Add core providers (Auth, Location, Ride)`
3. ✅ `feat: Add auth screens (Splash, Login, Signup)`
4. ✅ `feat: Add passenger screens (Home, Ride Request, Ride Details, History)`
5. ✅ `feat: Add driver screens (Home, Available Rides, Earnings)`
6. ✅ `feat: Add utilities, extensions, routing, and comprehensive README`

## Next Steps

1. Update Firebase configuration with your credentials
2. Test authentication flow
3. Test location services
4. Implement payment integration
5. Add real-time updates
6. Deploy to Play Store and App Store

## Support

For issues or questions:
- Check GitHub issues
- Review Firebase documentation
- Contact development team

---

**Version**: 1.0.0
**Last Updated**: 2026-09-04
**Status**: ✅ Ready for Development
