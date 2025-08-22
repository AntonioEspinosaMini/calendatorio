import '../../../../core/interfaces/calendar_repository.dart';

class UnmarkReminder {
  final CalendarRepository repository;
  UnmarkReminder(this.repository);

  Future<void> call(DateTime date, String reminderId) async {
    await repository.unmarkReminder(date, reminderId);
  }
}
