import '../../../../core/interfaces/reminder_repository.dart';

class DeleteReminder {
  final ReminderRepository repository;

  DeleteReminder(this.repository);

  Future<void> call(String id) async {
    await repository.deleteReminder(id);
  }
}
