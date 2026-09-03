import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/ride_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/ride_model.dart';
import 'ride_request_screen.dart';
import 'ride_history_screen.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({Key? key}) : super(key: key);

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  int _selectedIndex = 0;
  LocationData? _pickupLocation;
  LocationData? _dropoffLocation;

  @override
  void initState() {
    super.initState();
    _requestUserLocation();
  }

  void _requestUserLocation() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    await locationProvider.requestLocationPermission();
    await locationProvider.getCurrentLocation();
  }

  void _handleBookRide() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const RideRequestScreen(),
      ),
    );
  }

  void _handleLogout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIRGO'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _handleLogout();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: _buildBodyContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const RideHistoryScreen();
      case 2:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, _) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppTheme.primaryColor,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Location',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      locationProvider.address ?? 'Fetching location...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: _handleBookRide,
                        icon: const Icon(Icons.location_on),
                        label: const Text('Book a Ride'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Popular Rides',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildRideTypeCard('Economy', '100 PKR', Icons.directions_car),
                          const SizedBox(height: 12),
                          _buildRideTypeCard('Premium', '150 PKR', Icons.local_taxi),
                          const SizedBox(height: 12),
                          _buildRideTypeCard('Shared', '75 PKR', Icons.group),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRideTypeCard(String title, String price, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Starting from $price',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.currentUser;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user?.name ?? 'User',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.dividerColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildProfileInfo('Rating', '${user?.rating ?? 5.0} ⭐'),
                    const Divider(),
                    _buildProfileInfo('Total Rides', '${user?.rides ?? 0}'),
                    const Divider(),
                    _buildProfileInfo('Phone', user?.phone ?? ''),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: _handleLogout,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.errorColor),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: AppTheme.errorColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}