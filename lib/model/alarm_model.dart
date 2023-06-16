class Alarm {
  bool isActive;
  int hour;
  int minute;
  DateTime date;

  Alarm({
    required this.isActive,
    required this.hour,
    required this.minute,
    required this.date,
  });

  factory Alarm.fromMap(Map<String, dynamic> data) {
    final isActive = data['isActive'] as bool? ?? false;
    final hour = data['hour'] as int? ?? 0;
    final minute = data['minute'] as int? ?? 0;
    final dateString = data['date'] as String?;
    final date = dateString != null
        ? DateTime.tryParse(dateString) ?? DateTime.now()
        : DateTime.now();

    return Alarm(
      isActive: isActive,
      hour: hour,
      minute: minute,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'hour': hour,
      'minute': minute,
      'date': date.toIso8601String(),
    };
  }

  String getFormattedTime() {
    final String paddedHour = hour.toString().padLeft(2, '0');
    final String paddedMinute = minute.toString().padLeft(2, '0');
    return '$paddedHour:$paddedMinute';
  }

  String getFormattedDate() {
    final String dayName = getDayName(date.weekday);
    final String month = getMonthName(date.month);
    final String paddedDay = date.day.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return '$dayName, $month $paddedDay, $year';
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case DateTime.january:
        return 'January';
      case DateTime.february:
        return 'February';
      case DateTime.march:
        return 'March';
      case DateTime.april:
        return 'April';
      case DateTime.may:
        return 'May';
      case DateTime.june:
        return 'June';
      case DateTime.july:
        return 'July';
      case DateTime.august:
        return 'August';
      case DateTime.september:
        return 'September';
      case DateTime.october:
        return 'October';
      case DateTime.november:
        return 'November';
      case DateTime.december:
        return 'December';
      default:
        return '';
    }
  }
}
