class ApiEndpoints {
  static const String baseUrl = 'https://api.firgo.app';
  
  // Authentication
  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String logout = '$baseUrl/auth/logout';
  static const String refreshToken = '$baseUrl/auth/refresh';
  
  // Users
  static const String users = '$baseUrl/users';
  static String userById(String id) => '$users/$id';
  static String updateProfile(String id) => '$users/$id/profile';
  
  // Rides
  static const String rides = '$baseUrl/rides';
  static String rideById(String id) => '$rides/$id';
  static const String requestRide = '$rides/request';
  static const String cancelRide = '$rides/cancel';
  static const String completeRide = '$rides/complete';
  
  // Drivers
  static const String drivers = '$baseUrl/drivers';
  static String driverById(String id) => '$drivers/$id';
  static const String availableRides = '$drivers/available-rides';
  static const String acceptRide = '$drivers/accept-ride';
  static const String earnings = '$drivers/earnings';
  
  // Payments
  static const String payments = '$baseUrl/payments';
  static const String processPayment = '$payments/process';
  static const String refund = '$payments/refund';
}
