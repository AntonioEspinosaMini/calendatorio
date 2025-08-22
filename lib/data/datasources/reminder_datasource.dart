import '../../features/reminders/domain/entities/reminder_entity.dart';

/// Datasource para acceso a datos de recordatorios.
/// Inicialmente puede ser Hive, SQLite, o cualquier otra implementación.
abstract class ReminderDataSource {
  Future<List<ReminderEntity>> getAllReminders();
  Future<void> addReminder(ReminderEntity reminder);
  Future<void> updateReminder(ReminderEntity reminder);
  Future<void> deleteReminder(String reminderId);
}
