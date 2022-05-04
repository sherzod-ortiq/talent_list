extension StringExtension on String {
  String capitalize() {
    return isNotEmpty
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String shortFormat() {
    if (length > 40) {
      return '${substring(0, 40).capitalize().split('\n')[0]}...';
    }
    return capitalize().split('\n')[0];
  }
}
