import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DriverEarningsScreen extends StatelessWidget {
  const DriverEarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Earnings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.secondaryColor,
                  AppTheme.secondaryColor.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'Total Earnings',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'PKR 0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildEarningRow('Completed Rides', '0', 'PKR 0'),
          const SizedBox(height: 8),
          _buildEarningRow('Bonus', '0', 'PKR 0'),
          const SizedBox(height: 8),
          _buildEarningRow('Cancellations', '0', 'PKR 0'),
          const SizedBox(height: 24),
          const Text(
            'Weekly Earnings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
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
                _buildWeeklyRow('Monday', 'PKR 1200'),
                const Divider(),
                _buildWeeklyRow('Tuesday', 'PKR 1450'),
                const Divider(),
                _buildWeeklyRow('Wednesday', 'PKR 1300'),
                const Divider(),
                _buildWeeklyRow('Thursday', 'PKR 1600'),
                const Divider(),
                _buildWeeklyRow('Friday', 'PKR 1800'),
                const Divider(),
                _buildWeeklyRow('Saturday', 'PKR 2100'),
                const Divider(),
                _buildWeeklyRow('Sunday', 'PKR 1950'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Payment Methods',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildPaymentMethodCard('Bank Transfer', 'Allied Bank Limited', 'Last withdrawal: Today'),
          const SizedBox(height: 12),
          _buildPaymentMethodCard('JazzCash', '03XX-XXXXXX', 'Enabled'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Withdrawal request submitted')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryColor,
              ),
              child: const Text('Request Withdrawal'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningRow(String label, String rides, String amount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                rides,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textLight,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyRow(String day, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String method, String detail, String status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.dividerColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.account_balance,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.successColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}