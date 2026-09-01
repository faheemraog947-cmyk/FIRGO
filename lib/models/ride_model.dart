enum RideStatus {
  searching,
  accepted,
  onTheWay,
  arrived,
  inProgress,
  completed,
  cancelled,
}

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

class RideModel {
  final String rideId;
  final String passengerId;
  final String? driverId;
  final LocationData pickupLocation;
  final LocationData dropoffLocation;
  final RideStatus status;
  final DateTime requestedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final double estimatedFare;
  final double? actualFare;
  final double distance;
  final int estimatedTime; // in minutes
  final String rideType; // 'economy', 'premium', 'shared'
  final int passengers;
  final String? specialRequests;
  final bool? isSOS;
  final String? paymentMethod;
  final int? rating;
  final String? review;

  RideModel({
    required this.rideId,
    required this.passengerId,
    this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.status,
    required this.requestedAt,
    this.startedAt,
    this.completedAt,
    required this.estimatedFare,
    this.actualFare,
    required this.distance,
    required this.estimatedTime,
    required this.rideType,
    this.passengers = 1,
    this.specialRequests,
    this.isSOS = false,
    this.paymentMethod,
    this.rating,
    this.review,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      rideId: json['rideId'] as String,
      passengerId: json['passengerId'] as String,
      driverId: json['driverId'] as String?,
      pickupLocation: LocationData.fromJson(json['pickupLocation'] as Map<String, dynamic>),
      dropoffLocation: LocationData.fromJson(json['dropoffLocation'] as Map<String, dynamic>),
      status: RideStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => RideStatus.searching,
      ),
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      startedAt: json['startedAt'] != null ? DateTime.parse(json['startedAt'] as String) : null,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      estimatedFare: (json['estimatedFare'] as num).toDouble(),
      actualFare: (json['actualFare'] as num?)?.toDouble(),
      distance: (json['distance'] as num).toDouble(),
      estimatedTime: json['estimatedTime'] as int,
      rideType: json['rideType'] as String,
      passengers: json['passengers'] as int? ?? 1,
      specialRequests: json['specialRequests'] as String?,
      isSOS: json['isSOS'] as bool? ?? false,
      paymentMethod: json['paymentMethod'] as String?,
      rating: json['rating'] as int?,
      review: json['review'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rideId': rideId,
      'passengerId': passengerId,
      'driverId': driverId,
      'pickupLocation': pickupLocation.toJson(),
      'dropoffLocation': dropoffLocation.toJson(),
      'status': status.toString().split('.').last,
      'requestedAt': requestedAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'estimatedFare': estimatedFare,
      'actualFare': actualFare,
      'distance': distance,
      'estimatedTime': estimatedTime,
      'rideType': rideType,
      'passengers': passengers,
      'specialRequests': specialRequests,
      'isSOS': isSOS,
      'paymentMethod': paymentMethod,
      'rating': rating,
      'review': review,
    };
  }
}