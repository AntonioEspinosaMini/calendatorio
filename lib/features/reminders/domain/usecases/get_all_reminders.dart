import 'package:calendatorio/features/reminders/domain/entities/reminder_entity.dart';

import '../../../../core/interfaces/reminder_repository.dart';

class GetAllReminders {
  final ReminderRepository repository;

  GetAllReminders(this.repository);

  Future<List<ReminderEntity>> call() async {
    return await repository.getAllReminders();
  }
}
