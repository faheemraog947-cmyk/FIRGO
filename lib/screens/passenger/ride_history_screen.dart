import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ride_provider.dart';
import '../../theme/app_theme.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({Key? key}) : super(key: key);

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadRideHistory();
  }

  void _loadRideHistory() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final rideProvider = Provider.of<RideProvider>(context, listen: false);
    
    rideProvider.getRideHistory(authProvider.currentUser?.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RideProvider>(
      builder: (context, rideProvider, _) {
        if (rideProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (rideProvider.rideHistory.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 64,
                  color: AppTheme.textLight,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No Ride History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You haven\'t taken any rides yet',
                  style: TextStyle(
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: rideProvider.rideHistory.length,
          itemBuilder: (context, index) {
            final ride = rideProvider.rideHistory[index];
            return _buildRideHistoryCard(ride);
          },
        );
      },
    );
  }

  Widget _buildRideHistoryCard(dynamic ride) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Text(
                ride.rideType.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getRideStatusColor(ride.status),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _formatRideStatus(ride.status),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: AppTheme.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ride.pickupLocation.address,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.secondaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ride.dropoffLocation.address,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
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
                    '${ride.distance.toStringAsFixed(1)} km',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'Distance',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PKR ${ride.actualFare?.toStringAsFixed(0) ?? ride.estimatedFare.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  const Text(
                    'Fare',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
              if (ride.rating != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${ride.rating}⭐',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Rating',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getRideStatusColor(dynamic status) {
    switch (status.toString()) {
      case 'RideStatus.completed':
        return AppTheme.successColor;
      case 'RideStatus.cancelled':
        return AppTheme.errorColor;
      case 'RideStatus.inProgress':
        return AppTheme.primaryColor;
      default:
        return AppTheme.textLight;
    }
  }

  String _formatRideStatus(dynamic status) {
    final statusStr = status.toString().split('.').last;
    if (statusStr == 'inProgress') return 'In Progress';
    return statusStr[0].toUpperCase() + statusStr.substring(1);
  }
}