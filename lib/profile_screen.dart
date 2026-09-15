import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ride_service.dart';

class ProfileScreen extends StatelessWidget {
  final String driverId = 'faheem_driver_01'; // Mock Driver ID
  final RideService _rideService = RideService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('Profile & Wallet', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _rideService.getDriverProfile(driverId),
        builder: (context, snapshot) {
         double balance = 0.0;
          int ridesCount = 0;
          double rating = 5.0;

          if (snapshot.hasData && snapshot.data!.exists) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            balance = (data['walletBalance'] ?? 0.0).toDouble();
            ridesCount = (data['totalRides'] ?? 0).toInt();
            rating = (data['rating'] ?? 5.0).toDouble();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Driver Details Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFFFC107),
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Faheem Rao',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          Text('+92 300 1234567',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Realtime Wallet Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFFC107)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('FIRGO Wallet Balance',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(
                        'Rs. ${balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Color(0xFFFFC107),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const Divider(color: Colors.white24, height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Completed Rides: $ridesCount',
                              style: const TextStyle(color: Colors.white)),
                          Text('Rating: ${rating.toStringAsFixed(1)} ★',
    style: const TextStyle(color: Colors.amber)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}