import 'package:calendatorio/features/reminders/domain/entities/reminder_entity.dart';

import '../../../../core/interfaces/reminder_repository.dart';

class UpdateReminder {
  final ReminderRepository repository;

  UpdateReminder(this.repository);

  Future<void> call(ReminderEntity reminder) async {
    await repository.updateReminder(reminder);
  }
}
