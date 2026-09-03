import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ride_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/ride_model.dart';

class RideDetailsScreen extends StatefulWidget {
  final LocationData pickupLocation;
  final LocationData dropoffLocation;
  final double distance;
  final int estimatedTime;
  final String rideType;
  final int passengers;
  final String? specialRequests;

  const RideDetailsScreen({
    Key? key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.distance,
    required this.estimatedTime,
    required this.rideType,
    required this.passengers,
    this.specialRequests,
  }) : super(key: key);

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  bool _isRideRequested = false;
  RideModel? _currentRide;

  void _handleRequestRide() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final rideProvider = Provider.of<RideProvider>(context, listen: false);

    final success = await rideProvider.createRide(
      passengerId: authProvider.currentUser?.uid ?? '',
      pickupLocation: widget.pickupLocation,
      dropoffLocation: widget.dropoffLocation,
      distance: widget.distance,
      estimatedTime: widget.estimatedTime,
      rideType: widget.rideType,
      passengers: widget.passengers,
      specialRequests: widget.specialRequests,
    );

    if (success) {
      setState(() {
        _isRideRequested = true;
        _currentRide = rideProvider.currentRide;
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(rideProvider.error ?? 'Failed to request ride')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isRideRequested) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ride Details'),
          automaticallyImplyLeading: !_isRideRequested,
        ),
        body: _isRideRequested
            ? _buildRideSearching()
            : _buildRideDetails(),
      ),
    );
  }

  Widget _buildRideDetails() {
    double estimatedFare = 100 + (widget.distance * 10);
    if (widget.rideType == 'premium') {
      estimatedFare *= 1.5;
    } else if (widget.rideType == 'shared') {
      estimatedFare *= 0.75;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppTheme.primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pickup',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textLight,
                            ),
                          ),
                          Text(
                            widget.pickupLocation.address,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(
                  color: AppTheme.dividerColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: AppTheme.secondaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Dropoff',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textLight,
                            ),
                          ),
                          Text(
                            widget.dropoffLocation.address,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Trip Details',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Distance', '${widget.distance.toStringAsFixed(1)} km'),
          _buildDetailRow('Estimated Time', '${widget.estimatedTime} min'),
          _buildDetailRow('Ride Type', _capitalizeRideType(widget.rideType)),
          _buildDetailRow('Passengers', '${widget.passengers}'),
          const SizedBox(height: 24),
          const Text(
            'Fare Estimate',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.dividerColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Base Fare'),
                    Text('PKR 100'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Distance Charge'),
                    Text('PKR ${(widget.distance * 10).toStringAsFixed(0)}'),
                  ],
                ),
                if (widget.rideType != 'economy')
                  Column(
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('${_capitalizeRideType(widget.rideType)} Surcharge'),
                          Text(
                            'PKR ${((estimatedFare - (100 + (widget.distance * 10))).toStringAsFixed(0))}',
                          ),
                        ],
                      ),
                    ],
                  ),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'PKR ${estimatedFare.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _handleRequestRide,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryColor,
              ),
              child: const Text('Confirm & Request Ride'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideSearching() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.primaryColor,
              ),
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Finding a Driver...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we search for nearby drivers',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textLight,
            ),
          ),
          const SizedBox(height: 40),
          if (_currentRide != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text('Ride ID', style: TextStyle(color: AppTheme.textLight)),
                  Text(
                    _currentRide!.rideId,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Estimated Fare: PKR ${_currentRide!.estimatedFare.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _capitalizeRideType(String type) {
    return type[0].toUpperCase() + type.substring(1);
  }
}