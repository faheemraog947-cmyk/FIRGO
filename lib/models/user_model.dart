class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String userType; // 'passenger' or 'driver'
  final String profileImage;
  final double rating;
  final int rides;
  final bool isVerified;
  final DateTime createdAt;
  
  // Driver specific
  final String? vehicleNumber;
  final String? vehicleType;
  final String? vehicleColor;
  final String? licenseNumber;
  final bool? isOnline;
  final double? currentLatitude;
  final double? currentLongitude;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
    required this.profileImage,
    this.rating = 5.0,
    this.rides = 0,
    this.isVerified = false,
    required this.createdAt,
    this.vehicleNumber,
    this.vehicleType,
    this.vehicleColor,
    this.licenseNumber,
    this.isOnline = false,
    this.currentLatitude,
    this.currentLongitude,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      userType: json['userType'] as String,
      profileImage: json['profileImage'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      rides: json['rides'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      vehicleNumber: json['vehicleNumber'] as String?,
      vehicleType: json['vehicleType'] as String?,
      vehicleColor: json['vehicleColor'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      currentLatitude: (json['currentLatitude'] as num?)?.toDouble(),
      currentLongitude: (json['currentLongitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType,
      'profileImage': profileImage,
      'rating': rating,
      'rides': rides,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'vehicleNumber': vehicleNumber,
      'vehicleType': vehicleType,
      'vehicleColor': vehicleColor,
      'licenseNumber': licenseNumber,
      'isOnline': isOnline,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
    };
  }
}