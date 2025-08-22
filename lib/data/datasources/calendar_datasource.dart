import '../../features/calendar/domain/entities/calendar_day.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';

/// Datasource para acceso a datos del calendario.
/// Controla qué recordatorios están marcados en qué días.
abstract class CalendarDataSource {
  Future<List<CalendarDay>> getMonth(int year, int month);
  Future<void> markReminder(DateTime date, ReminderEntity reminder);
  Future<void> unmarkReminder(DateTime date, String reminderId);
  Future<void> clearReminderFromCalendar(String reminderId);
}
