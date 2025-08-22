import '../../../../core/interfaces/calendar_repository.dart';

class ClearReminderFromCalendar {
  final CalendarRepository repository;
  ClearReminderFromCalendar(this.repository);

  Future<void> call(String reminderId) async {
    await repository.clearReminderFromCalendar(reminderId);
  }
}
