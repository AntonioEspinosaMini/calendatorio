import '../../features/calendar/domain/entities/calendar_day.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';

/// Contrato para gestionar qué recordatorios están marcados en qué días.
abstract class CalendarRepository {
  /// Devuelve el estado de un mes completo (ej. agosto 2025).
  Future<List<CalendarDay>> getMonth(int year, int month);

  /// Marca un recordatorio en un día concreto.
  Future<void> markReminder(DateTime date, ReminderEntity reminder);

  /// Desmarca un recordatorio en un día concreto.
  Future<void> unmarkReminder(DateTime date, String reminderId);

  /// Elimina todas las marcas de un recordatorio (por ejemplo, si se borra).
  Future<void> clearReminderFromCalendar(String reminderId);
}
