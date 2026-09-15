class CommissionEngine {
  // Plan Types: '0_COMMISSION_PASS', 'PASS_A_5PERCENT', 'PASS_B_TIERED'
  
  static double calculatePlatformFee({
    required double fareAmount,
    required String activePlan,
    int totalRidesCompleted = 0,
  }) {
    switch (activePlan) {
      case '0_COMMISSION_PASS':
        // Pass system: 0% per-ride commission
        return 0.0;

      case 'PASS_A_5PERCENT':
        // Flat 5% platform fee
        return fareAmount * 0.05;

      case 'PASS_B_TIERED':
        // Tiered structure based on performance
        if (totalRidesCompleted > 50) {
          return fareAmount * 0.03; // 3% for top performers
        } else if (totalRidesCompleted > 20) {
          return fareAmount * 0.05; // 5% standard
        } else {
          return fareAmount * 0.08; // 8% initial tier
        }

      default:
        return fareAmount * 0.05;
    }
  }

  static double calculateDriverNetEarnings({
    required double fareAmount,
    required String activePlan,
    int totalRidesCompleted = 0,
  }) {
    double fee = calculatePlatformFee(
      fareAmount: fareAmount,
      activePlan: activePlan,
      totalRidesCompleted: totalRidesCompleted,
    );
    return fareAmount - fee;
  }
}