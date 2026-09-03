import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/ride_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/ride_model.dart';
import 'ride_details_screen.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({Key? key}) : super(key: key);

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  String _selectedRideType = 'economy';
  int _selectedPassengers = 1;
  bool _sosBtnEnabled = false;
  final _specialRequestsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _pickupController.text = locationProvider.address ?? 'Current Location';
  }

  void _handleConfirmRide() async {
    if (_dropoffController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter destination')),
      );
      return;
    }

    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final rideProvider = Provider.of<RideProvider>(context, listen: false);

    // Get coordinates for dropoff location
    List<dynamic>? dropoffCoords = await locationProvider.getCoordinatesFromAddress(
      _dropoffController.text,
    );

    if (dropoffCoords == null || dropoffCoords.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid destination')),
        );
      }
      return;
    }

    // Create location objects
    LocationData pickupLocation = LocationData(
      latitude: locationProvider.latitude ?? 0,
      longitude: locationProvider.longitude ?? 0,
      address: _pickupController.text,
    );

    LocationData dropoffLocation = LocationData(
      latitude: dropoffCoords[0].latitude,
      longitude: dropoffCoords[0].longitude,
      address: _dropoffController.text,
    );

    // Calculate distance and time
    double distance = locationProvider.calculateDistance(
      pickupLocation.latitude,
      pickupLocation.longitude,
      dropoffLocation.latitude,
      dropoffLocation.longitude,
    );

    int estimatedTime = (distance * 5).toInt(); // Rough estimate: 5 min per km

    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RideDetailsScreen(
            pickupLocation: pickupLocation,
            dropoffLocation: dropoffLocation,
            distance: distance,
            estimatedTime: estimatedTime,
            rideType: _selectedRideType,
            passengers: _selectedPassengers,
            specialRequests: _specialRequestsController.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pickup Location',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Current location',
              ),
              readOnly: true,
            ),
            const SizedBox(height: 24),
            const Text(
              'Dropoff Location',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _dropoffController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on_outlined),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _dropoffController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter destination',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Ride Type',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildRideTypeOption('Economy', 'economy'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRideTypeOption('Premium', 'premium'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRideTypeOption('Shared', 'shared'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Number of Passengers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.dividerColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        if (_selectedPassengers > 1) {
                          setState(() {
                            _selectedPassengers--;
                          });
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  Text(
                    '$_selectedPassengers',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        if (_selectedPassengers < 6) {
                          setState(() {
                            _selectedPassengers++;
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Special Requests',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _specialRequestsController,
              decoration: InputDecoration(
                hintText: 'Any special requests? (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            CheckboxListTile(
              title: const Text('Mark as SOS'),
              value: _sosBtnEnabled,
              onChanged: (value) {
                setState(() {
                  _sosBtnEnabled = value ?? false;
                });
              },
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _handleConfirmRide,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                ),
                child: const Text('Confirm Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideTypeOption(String label, String value) {
    bool isSelected = _selectedRideType == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRideType = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : Colors.transparent,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? AppTheme.primaryColor : AppTheme.textDark,
          ),
        ),
      ),
    );
  }
}