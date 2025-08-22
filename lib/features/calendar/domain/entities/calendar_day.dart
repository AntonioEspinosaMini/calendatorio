import '../../../reminders/domain/entities/reminder_entity.dart';

/// Representa un día del calendario con los recordatorios marcados.
/// Puede existir aunque no tenga recordatorios (días vacíos).
class CalendarDay {
  final DateTime date;
  final List<ReminderEntity> markedReminders;

  const CalendarDay({required this.date, this.markedReminders = const []});

  CalendarDay copyWith({
    DateTime? date,
    List<ReminderEntity>? markedReminders,
  }) {
    return CalendarDay(
      date: date ?? this.date,
      markedReminders: markedReminders ?? this.markedReminders,
    );
  }

  bool isReminderMarked(String reminderId) {
    return markedReminders.any((r) => r.id == reminderId);
  }

  @override
  String toString() =>
      'CalendarDay(date: $date, markedReminders: ${markedReminders.length})';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarDay &&
          runtimeType == other.runtimeType &&
          date.year == other.date.year &&
          date.month == other.date.month &&
          date.day == other.date.day &&
          markedReminders == other.markedReminders;

  @override
  int get hashCode =>
      date.year.hashCode ^
      date.month.hashCode ^
      date.day.hashCode ^
      markedReminders.hashCode;
}
