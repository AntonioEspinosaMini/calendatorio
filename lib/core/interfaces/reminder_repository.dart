import '../../features/reminders/domain/entities/reminder_entity.dart';

/// Contrato para gestionar los recordatorios definidos por el usuario.
abstract class ReminderRepository {
  /// Devuelve todos los recordatorios definidos por el usuario.
  Future<List<ReminderEntity>> getAllReminders();

  /// Añade un nuevo recordatorio.
  Future<void> addReminder(ReminderEntity reminder);

  /// Elimina un recordatorio por su ID.
  Future<void> deleteReminder(String reminderId);

  /// Actualiza un recordatorio existente.
  Future<void> updateReminder(ReminderEntity reminder);
}
