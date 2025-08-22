import '../../core/interfaces/reminder_repository.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';
import '../datasources/reminder_datasource.dart';

/// Implementación de ReminderRepository usando un datasource concreto.
/// Por ahora, los métodos lanzan UnimplementedError para definir el flujo.
class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderDataSource dataSource;

  ReminderRepositoryImpl({required this.dataSource});

  @override
  Future<void> addReminder(ReminderEntity reminder) async {
    await dataSource.addReminder(reminder);
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    await dataSource.deleteReminder(reminderId);
  }

  @override
  Future<List<ReminderEntity>> getAllReminders() async {
    return await dataSource.getAllReminders();
  }

  @override
  Future<void> updateReminder(ReminderEntity reminder) async {
    await dataSource.updateReminder(reminder);
  }
}
