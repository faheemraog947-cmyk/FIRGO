import 'package:flutter/material.dart';

class VehicleOption {
  final String id;
  final String title;
  final String price;
  final String iconPath;

  VehicleOption({
    required this.id,
    required this.title,
    required this.price,
    required this.iconPath,
  });
}

class RideOptionsSheet extends StatefulWidget {
  final Function(String vehicleType, String paymentMethod) onConfirm;

  const RideOptionsSheet({Key? key, required this.onConfirm}) : super(key: key);

  @override
  State<RideOptionsSheet> createState() => _RideOptionsSheetState();
}

class _RideOptionsSheetState extends State<RideOptionsSheet> {
  String selectedVehicle = 'economy';
  String selectedPayment = 'JazzCash';

  final List<VehicleOption> vehicles = [
    VehicleOption(id: 'economy', title: 'Economy', price: 'Rs. 435', iconPath: 'assets/economy.png'),
    VehicleOption(id: 'comfort', title: 'Comfort', price: 'Rs. 3300', iconPath: 'assets/comfort.png'),
    VehicleOption(id: 'premium', title: 'Premium', price: 'Rs. 4355', iconPath: 'assets/premium.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0C10), // FIRGO Obsidian Black
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Vehicle Model',
            style: TextStyle(color: Color(0xFFFFBF00), fontSize: 18, fontWeight: FontWeight.bold), // FIRGO Gold
          ),
          const SizedBox(height: 12),
          
          // Vehicle Options List
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: vehicles.map((v) {
              bool isSelected = selectedVehicle == v.id;
              return GestureDetector(
                onTap: () => setState(() => selectedVehicle = v.id),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFBF00).withOpacity(0.2) : Colors.grey[900],
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFFBF00) : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.directions_car, color: isSelected ? const Color(0xFFFFBF00) : Colors.white, size: 36),
                      const SizedBox(height: 6),
                      Text(v.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(v.price, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          const Text('Payment Method', style: TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),

          // Local Payment Options (JazzCash / EasyPaisa / Cash)
          Row(
            children: ['JazzCash', 'EasyPaisa', 'Cash'].map((method) {
              bool isSelected = selectedPayment == method;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(method),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFFBF00),
                    onSelected: (bool selected) {
                      if (selected) setState(() => selectedPayment = method);
                    },
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),
          
          // Confirm Ride Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFBF00),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => widget.onConfirm(selectedVehicle, selectedPayment),
              child: const Text('Confirm Ride', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}