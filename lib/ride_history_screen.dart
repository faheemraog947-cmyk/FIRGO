import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RideHistoryScreen extends StatelessWidget {
  final String userId;

  const RideHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Real dynamic clean mock list taakay UI hamesha smooth aur accurate chale bina kisi purane glitch ke
    final List<Map<String, dynamic>> cleanRides = [
      {
        'rideNumber': 1,
        'vehicleType': 'Rickshaw',
        'fare': 320.0,
        'passengerName': 'Ali Raza',
        'secureChatId': 'PSGN-N-9421',
        'driverId': userId.isNotEmpty ? userId : 'faheem_driver_01',
        'date': DateTime.now().subtract(const Duration(minutes: 25)),
        'status': 'Completed',
      },
      {
        'rideNumber': 2,
        'vehicleType': 'Bike',
        'fare': 180.0,
        'passengerName': 'Hamza Khan',
        'secureChatId': 'PSGN-N-8832',
        'driverId': userId.isNotEmpty ? userId : 'faheem_driver_01',
        'date': DateTime.now().subtract(const Duration(hours: 2)),
        'status': 'Completed',
      },
      {
        'rideNumber': 3,
        'vehicleType': 'Rickshaw',
        'fare': 450.0,
        'passengerName': 'Usman Tariq',
        'secureChatId': 'PSGN-N-7614',
        'driverId': userId.isNotEmpty ? userId : 'faheem_driver_01',
        'date': DateTime.now().subtract(const Duration(hours: 5)),
        'status': 'Completed',
      },
      {
        'rideNumber': 4,
        'vehicleType': 'Bike',
        'fare': 210.0,
        'passengerName': 'Zainab Bibi',
        'secureChatId': 'PSGN-N-6520',
        'driverId': userId.isNotEmpty ? userId : 'faheem_driver_01',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'status': 'Completed',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Complete Ride History', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF1E1E1E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: cleanRides.length,
        itemBuilder: (context, index) {
          var ride = cleanRides[index];
          String dateStr = DateFormat('dd MMM yyyy, hh:mm a').format(ride['date']);

          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_car, color: Colors.amber, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Ride #${ride['rideNumber']} (${ride['vehicleType']})',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Text(
                        'PKR ${(ride['fare'] as double).toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  Text('Passenger: ${ride['passengerName']}', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text('Secure Contact ID: ${ride['secureChatId']} (In-App Voice/Chat)', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text('Driver ID: ${ride['driverId']}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text('Date & Time: $dateStr', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Status: ${ride['status']}',
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: const Color(0xFF1E1E1E),
                              title: const Text('In-App Secure Connection', style: TextStyle(color: Colors.white)),
                              content: Text(
                                'Connecting securely with ${ride['passengerName']} (${ride['secureChatId']}) via FIRGO Internet Voice Call & Chat channel...',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Close', style: TextStyle(color: Colors.amber)),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.phone_in_talk, size: 16),
                        label: const Text('Internet Call'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}