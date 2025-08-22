import 'package:calendatorio/features/reminders/domain/entities/reminder_entity.dart';

import '../../../../core/interfaces/reminder_repository.dart';

class AddReminder {
  final ReminderRepository repository;

  AddReminder(this.repository);

  Future<void> call(ReminderEntity reminder) async {
    await repository.addReminder(reminder);
  }
}
