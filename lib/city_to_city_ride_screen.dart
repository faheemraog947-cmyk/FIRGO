import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CityToCityRideScreen extends StatefulWidget {
  final String userId;
  final double estimatedDistanceKm; // e.g., 50.0 KM

  const CityToCityRideScreen({
    Key? key,
    required this.userId,
    required this.estimatedDistanceKm,
  }) : super(key: key);

  @override
  _CityToCityRideScreenState createState() => _CityToCityRideScreenState();
}

class _CityToCityRideScreenState extends State<CityToCityRideScreen> {
  final TextEditingController _fareController = TextEditingController();
  late double _recommendedFare;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Base rate calculation (e.g., Rs. 50 per KM for Inter-City)
    _recommendedFare = widget.estimatedDistanceKm * 50;
    _fareController.text = _recommendedFare.toStringAsFixed(0);
  }

  Future<void> _requestInterCityRide() async {
    setState(() => _isLoading = true);

    double offeredFare = double.tryParse(_fareController.text) ?? _recommendedFare;

    try {
      await FirebaseFirestore.instance.collection('rides').add({
        'passengerId': widget.userId,
        'rideType': 'City to City',
        'distanceKm': widget.estimatedDistanceKm,
        'offeredFare': offeredFare,
        'status': 'PENDING', // PENDING, ACCEPTED, COUNTER_OFFERED
        'createdAt': FieldValue.serverTimestamp(),
        'requiresHighwayApprovedVehicle': true, // Filter for bypass/highway eligible vehicles
        'allowedVehicleTypes': ['Sedan', 'AC Car', 'SUV'], 
        'minVehicleYear': 2015,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inter-City Ride offer broadcasted to qualified drivers!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating ride: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Obsidian Black background
      appBar: AppBar(
        title: const Text('FIRGO City to City', style: TextStyle(color: Color(0xFFFFBF00))),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFFBF00)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inter-City Highway Route',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Distance: ${widget.estimatedDistanceKm} KM (Bypass Route)',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Fare Offer Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFBF00), width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Offer Your Fare (PKR)',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _fareController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Color(0xFFFFBF00), fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      prefixText: 'Rs. ',
                      prefixStyle: TextStyle(color: Color(0xFFFFBF00), fontSize: 22),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBF00))),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBF00), width: 2)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Suggested Fare: Rs. ${_recommendedFare.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            
            const Spacer(),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFBF00), // Amber Gold
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isLoading ? null : _requestInterCityRide,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Offer Fare to Drivers',
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}