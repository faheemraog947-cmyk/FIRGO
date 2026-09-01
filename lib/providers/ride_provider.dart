import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride_model.dart';

class RideProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RideModel? _currentRide;
  List<RideModel> _rideHistory = [];
  bool _isLoading = false;
  String? _error;

  RideModel? get currentRide => _currentRide;
  List<RideModel> get rideHistory => _rideHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> createRide({
    required String passengerId,
    required LocationData pickupLocation,
    required LocationData dropoffLocation,
    required double distance,
    required int estimatedTime,
    required String rideType,
    required int passengers,
    String? specialRequests,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      double estimatedFare = 100 + (distance * 10);
      if (rideType == 'premium') {
        estimatedFare *= 1.5;
      } else if (rideType == 'shared') {
        estimatedFare *= 0.75;
      }

      String rideId = _firestore.collection('rides').doc().id;
      RideModel newRide = RideModel(
        rideId: rideId,
        passengerId: passengerId,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        status: RideStatus.searching,
        requestedAt: DateTime.now(),
        estimatedFare: estimatedFare,
        distance: distance,
        estimatedTime: estimatedTime,
        rideType: rideType,
        passengers: passengers,
        specialRequests: specialRequests,
      );

      await _firestore.collection('rides').doc(rideId).set(newRide.toJson());
      _currentRide = newRide;

      _isLoading = false;
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create ride';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> acceptRide(String rideId, String driverId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('rides').doc(rideId).update({
        'driverId': driverId,
        'status': 'accepted',
      });

      if (_currentRide?.rideId == rideId) {
        _currentRide = _currentRide!.copyWith(driverId: driverId, status: RideStatus.accepted);
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to accept ride';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeRide(String rideId, double actualFare) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestore.collection('rides').doc(rideId).update({
        'status': 'completed',
        'completedAt': DateTime.now().toIso8601String(),
        'actualFare': actualFare,
      });

      if (_currentRide?.rideId == rideId) {
        _currentRide = _currentRide!.copyWith(
          status: RideStatus.completed,
          completedAt: DateTime.now(),
          actualFare: actualFare,
        );
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to complete ride';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> getRideHistory(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('rides')
          .where('passengerId', isEqualTo: userId)
          .orderBy('requestedAt', descending: true)
          .limit(20)
          .get();

      _rideHistory = snapshot.docs
          .map((doc) => RideModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Failed to fetch ride history';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> rateRide(String rideId, int rating, String review) async {
    try {
      await _firestore.collection('rides').doc(rideId).update({
        'rating': rating,
        'review': review,
      });

      if (_currentRide?.rideId == rideId) {
        _currentRide = _currentRide!.copyWith(rating: rating, review: review);
        notifyListeners();
      }

      return true;
    } catch (e) {
      _error = 'Failed to rate ride';
      notifyListeners();
      return false;
    }
  }
}

extension RideModelCopyWith on RideModel {
  RideModel copyWith({
    String? rideId,
    String? passengerId,
    String? driverId,
    LocationData? pickupLocation,
    LocationData? dropoffLocation,
    RideStatus? status,
    DateTime? requestedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    double? estimatedFare,
    double? actualFare,
    double? distance,
    int? estimatedTime,
    String? rideType,
    int? passengers,
    String? specialRequests,
    bool? isSOS,
    String? paymentMethod,
    int? rating,
    String? review,
  }) {
    return RideModel(
      rideId: rideId ?? this.rideId,
      passengerId: passengerId ?? this.passengerId,
      driverId: driverId ?? this.driverId,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      actualFare: actualFare ?? this.actualFare,
      distance: distance ?? this.distance,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      rideType: rideType ?? this.rideType,
      passengers: passengers ?? this.passengers,
      specialRequests: specialRequests ?? this.specialRequests,
      isSOS: isSOS ?? this.isSOS,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      rating: rating ?? this.rating,
      review: review ?? this.review,
    );
  }
}