extension StringExtension on String {
  String capitalize() {
    return isNotEmpty
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String shortFormat(int allowedLen) {
    if (length > allowedLen) {
      return '${substring(0, allowedLen).capitalize().split('\n')[0]}...';
    }
    return capitalize().split('\n')[0];
  }
}
