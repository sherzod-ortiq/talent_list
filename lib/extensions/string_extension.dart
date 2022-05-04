extension StringExtension on String {
  String capitalize() {
    return isNotEmpty
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String shortFormat(int length) {
    if (this.length > length) {
      return '${capitalize().substring(0, length)}...';
    }
    return capitalize();
  }
}
