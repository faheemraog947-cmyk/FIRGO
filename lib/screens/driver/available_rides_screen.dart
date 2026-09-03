import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class AvailableRidesScreen extends StatefulWidget {
  const AvailableRidesScreen({Key? key}) : super(key: key);

  @override
  State<AvailableRidesScreen> createState() => _AvailableRidesScreenState();
}

class _AvailableRidesScreenState extends State<AvailableRidesScreen> {
  // Mock available rides data
  final List<Map<String, dynamic>> availableRides = [
    {
      'id': '1',
      'pickup': 'DHA, Karachi',
      'dropoff': 'Clifton, Karachi',
      'distance': 5.2,
      'fare': 250,
      'passengers': 1,
      'type': 'economy',
      'waitTime': 2,
    },
    {
      'id': '2',
      'pickup': 'Saddar, Karachi',
      'dropoff': 'Airport, Karachi',
      'distance': 15.8,
      'fare': 450,
      'passengers': 2,
      'type': 'premium',
      'waitTime': 1,
    },
    {
      'id': '3',
      'pickup': 'Gulistan-e-Jauhar, Karachi',
      'dropoff': 'Defence, Karachi',
      'distance': 8.5,
      'fare': 320,
      'passengers': 3,
      'type': 'shared',
      'waitTime': 3,
    },
  ];

  void _acceptRide(String rideId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ride $rideId accepted! Heading to pickup location.'),
        backgroundColor: AppTheme.successColor,
      ),
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          availableRides.removeWhere((ride) => ride['id'] == rideId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
      ),
      body: availableRides.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 64,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Available Rides',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check back soon for new ride requests',
                    style: TextStyle(
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: availableRides.length,
              itemBuilder: (context, index) {
                final ride = availableRides[index];
                return _buildRideCard(ride);
              },
            ),
    );
  }

  Widget _buildRideCard(Map<String, dynamic> ride) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRideTypeColor(ride['type']),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ride['type'].toString().toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${ride['waitTime']} min wait',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 16, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ride['pickup'],
                  style: const TextStyle(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.secondaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ride['dropoff'],
                  style: const TextStyle(fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ride['distance']} km',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Distance',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PKR ${ride['fare']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  const Text(
                    'Fare',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${ride['passengers']} ${ride['passengers'] > 1 ? 'Pax' : 'Pax'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Passengers',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                _acceptRide(ride['id']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryColor,
              ),
              child: const Text('Accept Ride'),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRideTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'economy':
        return AppTheme.primaryColor;
      case 'premium':
        return const Color(0xFFD4AF37);
      case 'shared':
        return Colors.green;
      default:
        return AppTheme.textLight;
    }
  }
}