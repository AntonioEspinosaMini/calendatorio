import '../../core/interfaces/calendar_repository.dart';
import '../../features/calendar/domain/entities/calendar_day.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';
import '../datasources/calendar_datasource.dart';

/// Implementación de CalendarRepository usando un datasource concreto.
class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarDataSource dataSource;

  CalendarRepositoryImpl({required this.dataSource});

  @override
  Future<void> clearReminderFromCalendar(String reminderId) async {
    await dataSource.clearReminderFromCalendar(reminderId);
  }

  @override
  Future<List<CalendarDay>> getMonth(int year, int month) async {
    return await dataSource.getMonth(year, month);
  }

  @override
  Future<void> markReminder(DateTime date, ReminderEntity reminder) async {
    await dataSource.markReminder(date, reminder);
  }

  @override
  Future<void> unmarkReminder(DateTime date, String reminderId) async {
    await dataSource.unmarkReminder(date, reminderId);
  }
}
