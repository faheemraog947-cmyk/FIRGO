import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ride_service.dart';
import 'passenger_rating_dialog.dart';
import '../services/call_service.dart';
class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  final RideService _rideService = RideService();
  final String _driverId = 'faheem_driver_01'; // Mock Driver ID

  String _selectedVehicle = 'Bike';
  double _fare = 140.00;
  bool _isBooking = false;

  // Active Ride Trackers
  String? _activeRideId;
  double _activeFare = 0.0;
  bool _hasActiveRide = false;

  @override
  void initState() {
    super.initState();
    _listenForIncomingRides();
  }

  void _listenForIncomingRides() {
    _rideService.getPendingRideRequests(_selectedVehicle).listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added && !_hasActiveRide) {
          var rideData = change.doc.data() as Map<String, dynamic>;
          _showRideRequestDialog(change.doc.id, rideData);
        }
      }
    });
  }

  void _showRideRequestDialog(String rideId, Map<String, dynamic> data) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Row(
          children: const [
            Icon(Icons.directions_car, color: Color(0xFFFFC107)),
            SizedBox(width: 8),
            Text('New Ride Request!', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Passenger: ${data['passengerName'] ?? 'Customer'}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text('Vehicle: ${data['vehicleType']}',
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text('Total Fare: PKR ${data['fare']}',
                style: const TextStyle(
                    color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
            Text('FIRGO Fee (10%): PKR ${data['firgoFee']}',
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Decline', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
            ),
            onPressed: () async {
              await _rideService.acceptRide(rideId, 'Faheem Driver');
              if (mounted) {
                Navigator.pop(context);
                setState(() {
                  _hasActiveRide = true;
                  _activeRideId = rideId;
                  _activeFare = (data['fare'] as num).toDouble();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ride Accepted! Driving to destination...'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Accept Ride',
                style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Future<void> _completeActiveRide() async {
    if (_activeRideId == null) return;

    setState(() => _isBooking = true);
    try {
      await _rideService.completeRide(
        rideId: _activeRideId!,
        driverId: _driverId,
        fare: _activeFare,
      );

      setState(() {
        _hasActiveRide = false;
        _activeRideId = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Ride Completed! Earnings PKR ${(_activeFare * 0.90).toStringAsFixed(2)} added to Wallet.'),
            backgroundColor: Colors.amber,
          ),
        );
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PassengerRatingDialog(
          driverId: _driverId,
          rideService: _rideService,
        ),
      );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isBooking = false);
    }
  }

  Future<void> _handleBooking() async {
    setState(() => _isBooking = true);
    try {
      await _rideService.createRideRequest(
        passengerName: 'Passenger User',
        vehicleType: _selectedVehicle,
        fare: _fare,
        pickupLocation: 'Current Location',
        dropLocation: 'Destination Location',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ride Request Sent! Waiting for driver...'),
          backgroundColor: Colors.amber,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isBooking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text('FIRGO Rides', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFFC107),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!_hasActiveRide) ...[
              DropdownButton<String>(
                value: _selectedVehicle,
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(color: Colors.white),
                isExpanded: true,
                items: ['Bike', 'Rickshaw', 'Car']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedVehicle = val;
                      _fare = val == 'Bike'
                          ? 140.0
                          : val == 'Rickshaw'
                              ? 350.0
                              : 600.0;
                    });
                  }
                },
              ),
              const Spacer(),
              Text(
                'Total Fare: PKR ${_fare.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'FIRGO Fee (10%): PKR ${(_fare * 0.10).toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isBooking ? null : _handleBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isBooking
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'Book Ride Now',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ] else ...[
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.navigation, color: Colors.green, size: 40),
                    const SizedBox(height: 10),
                    const Text(
                      'Ride In Progress',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fare: PKR ${_activeFare.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Color(0xFFFFC107), fontSize: 16),
                    ),
                    Text(
                      'Your Earning (90%): PKR ${(_activeFare * 0.90).toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isBooking ? null : _completeActiveRide,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isBooking
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Complete Ride & Collect Fare',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ],
        ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF1F2833),
        icon: const Icon(Icons.phone, color: Color(0xFFFFBF00)),
        label: const Text('Call Driver', style: TextStyle(color: Color(0xFFFFBF00))),
        onPressed: () {
          CallService.showCallSheet(
            context,
            driverName: 'Ali Raza',
            phoneNumber: '+923001234567',
          );
        },
      ),
      ),
    );
  }
}