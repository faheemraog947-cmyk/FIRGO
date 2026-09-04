extension NumExtension on num {
  String toCurrency() {
    return 'PKR ${toStringAsFixed(2)}';
  }

  String toDistance() {
    return '${toStringAsFixed(1)} km';
  }

  String toTime() {
    if (this < 60) {
      return '${toInt()} min';
    }
    final hours = (this / 60).toInt();
    final mins = (this % 60).toInt();
    return '$hours hr ${mins > 0 ? mins : 0} min';
  }
}
