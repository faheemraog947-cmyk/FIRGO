import 'package:flutter/material.dart';

class RemoteBookingDialog extends StatefulWidget {
  final Function(String name, String phone) onBookingConfirmed;

  const RemoteBookingDialog({Key? key, required this.onBookingConfirmed}) : super(key: key);

  @override
  _RemoteBookingDialogState createState() => _RemoteBookingDialogState();
}

class _RemoteBookingDialogState extends State<RemoteBookingDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1A1A1A), // Dark Glassmorphism style
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFFFBF00), width: 1), // Amber Gold
      ),
      title: const Text(
        'Book Ride for Someone Else',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter the passenger details who will be taking this ride.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Passenger Name',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBF00))),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBF00), width: 2)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Passenger Phone (+92)',
              labelStyle: TextStyle(color: Colors.grey),
              prefixText: '+92 ',
              prefixStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBF00))),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFBF00), width: 2)),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFBF00),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
              widget.onBookingConfirmed(_nameController.text, '+92${_phoneController.text}');
              Navigator.pop(context);
            }
          },
          child: const Text('Confirm Passenger', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}