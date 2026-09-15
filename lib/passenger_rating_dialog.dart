import 'package:flutter/material.dart';
import 'ride_service.dart';

class PassengerRatingDialog extends StatefulWidget {
  final String driverId;
  final RideService rideService;

  const PassengerRatingDialog({
    Key? key,
    required this.driverId,
    required this.rideService,
  }) : super(key: key);

  @override
  State<PassengerRatingDialog> createState() => _PassengerRatingDialogState();
}

class _PassengerRatingDialogState extends State<PassengerRatingDialog> {
  double _selectedRating = 5.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Rate Your Driver ⭐️',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'How was your ride experience?',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = index + 1.0;
                  });
                },
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Skip', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFC107),
            foregroundColor: Colors.black,
          ),
          onPressed: () async {
            await widget.rideService.submitDriverRating(
              driverId: widget.driverId,
              newRating: _selectedRating,
            );
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Rating Submitted Successfully!')),
              );
            }
          },
          child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}