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
}
