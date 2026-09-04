import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'FIRGO';
  static const String appVersion = '1.0.0';
  static const String companyName = 'FIRGO Inc';
  
  // Ride Types
  static const List<String> rideTypes = ['economy', 'premium', 'shared'];
  static const Map<String, double> ridePricing = {
    'economy': 1.0,
    'premium': 1.5,
    'shared': 0.75,
  };
  
  // Base Fare
  static const double baseFare = 100.0; // PKR
  static const double perKmCharge = 10.0; // PKR per km
  static const double perMinuteCharge = 2.0; // PKR per minute
  
  // Ratings
  static const int maxRating = 5;
  static const double minRatingToKeepProfile = 4.0;
  
  // Document Size Limits
  static const int maxProfileImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxDocumentFileSize = 10 * 1024 * 1024; // 10MB
  
  // Timeouts
  static const Duration rideSearchTimeout = Duration(minutes: 5);
  static const Duration locationUpdateInterval = Duration(seconds: 30);
  
  // Pakistan
  static const double defaultLatitude = 24.8607;
  static const double defaultLongitude = 67.0011;
  static const String defaultCity = 'Karachi';
  static const String countryCode = '+92';
  
  // Error Messages
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorServer = 'Server error. Please try again later.';
  static const String errorUnknown = 'An unknown error occurred.';
  static const String errorInvalidEmail = 'Please enter a valid email address.';
  static const String errorPasswordTooShort = 'Password must be at least 6 characters.';
  static const String errorPasswordMismatch = 'Passwords do not match.';
  
  // Success Messages
  static const String successRegistration = 'Account created successfully!';
  static const String successLogin = 'Login successful!';
  static const String successRideRequest = 'Ride requested successfully!';
  static const String successRideAccepted = 'Ride accepted!';
  static const String successRideCompleted = 'Ride completed!';
  static const String successProfileUpdated = 'Profile updated successfully!';
  
  // Date Format
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  
  // Pagination
  static const int itemsPerPage = 20;
  static const int maxPages = 100;
}
