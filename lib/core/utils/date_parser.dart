String formatDateTime(DateTime? dateTime) {
  if (dateTime == null) {
    return 'NA -';
  }

  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));

  // Define a dictionary for month abbreviations
  final Map<int, String> monthAbbreviations = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec',
  };

  // Check if the date is today or yesterday
  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return 'Today';
  } else if (dateTime.year == yesterday.year &&
      dateTime.month == yesterday.month &&
      dateTime.day == yesterday.day) {
    return 'Yesterday';
  } else {
    // Get the abbreviated month name from the dictionary
    String monthString = monthAbbreviations[dateTime.month] ?? '';

    // Format the date string
    String formattedDate = '$monthString ${dateTime.day}, ${dateTime.year}';

    return formattedDate;
  }
}
