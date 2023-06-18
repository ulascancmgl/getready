class Alarm2 {
  bool isActive;
  int hour;
  int minute;
  List<int> days;

  Alarm2({
    required this.isActive,
    required this.hour,
    required this.minute,
    required this.days,
  });

  factory Alarm2.fromMap(Map<String, dynamic> data) {
    final isActive = data['isActive'] as bool? ?? false;
    final hour = data['hour'] as int? ?? 0;
    final minute = data['minute'] as int? ?? 0;
    final daysList = (data['days'] as List<dynamic>?)?.cast<int>() ?? [];

    return Alarm2(
      isActive: isActive,
      hour: hour,
      minute: minute,
      days: daysList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'hour': hour,
      'minute': minute,
      'days': days,
    };
  }
}
