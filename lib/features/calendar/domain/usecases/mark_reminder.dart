import '../../../../core/interfaces/calendar_repository.dart';
import '../../../reminders/domain/entities/reminder_entity.dart';

class MarkReminder {
  final CalendarRepository repository;
  MarkReminder(this.repository);

  Future<void> call(DateTime date, ReminderEntity reminder) async {
    await repository.markReminder(date, reminder);
  }
}
