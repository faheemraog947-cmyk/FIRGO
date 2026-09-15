import 'package:cloud_firestore/cloud_firestore.dart';

class RideService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ride request create karna (Customer Side)
  Future<String> createRideRequest({
    required String passengerName,
    required String vehicleType,
    required double fare,
    required String pickupLocation,
    required String dropLocation,
  }) async {
    DocumentReference docRef = await _db.collection('ride_requests').add({
      'passengerName': passengerName,
      'vehicleType': vehicleType,
      'fare': fare,
      'firgoFee': fare * 0.10,
      'status': 'pending', // pending, accepted, completed, cancelled
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  // Pending rides listen karna (Driver Side)
  Stream<QuerySnapshot> getPendingRideRequests(String vehicleType) {
    return _db
        .collection('ride_requests')
        .where('status', isEqualTo: 'pending')
        .where('vehicleType', isEqualTo: vehicleType)
        .snapshots();
  }

  // Ride Accept karna
  Future<void> acceptRide(String rideId, String driverName) async {
    await _db.collection('ride_requests').doc(rideId).update({
      'status': 'accepted',
      'driverName': driverName,
      'acceptedAt': FieldValue.serverTimestamp(),
    });
  }

  // Ride Complete karna & Wallet Balance update karna
  Future<void> completeRide({
    required String rideId,
    required String driverId,
    required double fare,
  }) async {
    double driverEarning = fare * 0.90; // 90% Driver, 10% FIRGO Fee

    WriteBatch batch = _db.batch();

    // 1. Ride Status Update
    DocumentReference rideRef = _db.collection('ride_requests').doc(rideId);
    batch.update(rideRef, {'status': 'completed'});

    // 2. Driver Wallet Balance Update
    DocumentReference driverRef = _db.collection('users').doc(driverId);
    batch.set(
      driverRef,
      {
        'walletBalance': FieldValue.increment(driverEarning),
        'totalRides': FieldValue.increment(1),
      },
      SetOptions(merge: true),
    );

    await batch.commit();
  }

  // Real-time Wallet Stream
  Stream<DocumentSnapshot> getDriverProfile(String driverId) {
    return _db.collection('users').doc(driverId).snapshots();
  }// Submit driver rating and update average rating in Firestore
  Future<void> submitDriverRating({
    required String driverId,
    required double newRating,
  }) async {
    DocumentReference driverRef = _db.collection('users').doc(driverId);

    await _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(driverRef);

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        double currentRating = (data['rating'] ?? 5.0).toDouble();
        int ratingCount = (data['ratingCount'] ?? 1).toInt();

        // Formula for average rating
        double updatedRating =
            ((currentRating * ratingCount) + newRating) / (ratingCount + 1);
        int updatedCount = ratingCount + 1;

        transaction.update(driverRef, {
          'rating': double.parse(updatedRating.toStringAsFixed(1)),
          'ratingCount': updatedCount,
        });
      }
    });
  }
}