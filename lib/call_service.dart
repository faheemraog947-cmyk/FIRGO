import 'package:flutter/material.dart';

class CallService {
  // Trigger In-App Call Bottom Sheet
  static void showCallSheet(BuildContext context, {required String driverName, required String phoneNumber}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B0C10), // Obsidian Black
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFFFBF00), // Amber Gold
                child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Text(
                driverName,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'FIRGO Secure Voice Call',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // End Call Button
                  IconButton(
                    iconSize: 50,
                    icon: const Icon(Icons.call_end, color: Colors.redAccent),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Start Call Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFBF00),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    icon: const Icon(Icons.phone, color: Colors.black),
                    label: const Text(
                      'Call Driver',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Logic for VoIP / Agora / Native Phone dialer
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Calling $driverName...')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}