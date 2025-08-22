import 'package:hive/hive.dart';
import '../../features/calendar/domain/entities/calendar_day.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';
import 'calendar_datasource.dart';

class HiveCalendarDataSource implements CalendarDataSource {
  static const String boxName = 'calendarBox';

  Future<Box> _openBox() async => await Hive.openBox(boxName);

  String _dateKey(DateTime date) => '${date.year}-${date.month}-${date.day}';

  @override
  Future<void> clearReminderFromCalendar(String reminderId) async {
    final box = await _openBox();
    for (var key in box.keys) {
      List<dynamic> ids = box.get(key);
      ids.remove(reminderId);
      await box.put(key, ids);
    }
  }

  @override
  Future<List<CalendarDay>> getMonth(int year, int month) async {
    final box = await _openBox();
    List<CalendarDay> days = [];
    final daysInMonth = DateTime(year, month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      final key = _dateKey(date);
      List<String> reminderIds = List<String>.from(
        box.get(key, defaultValue: []),
      );
      final reminders = reminderIds
          .map((id) => ReminderEntity(id: id, name: '', colorIndex: 0))
          .toList();
      days.add(CalendarDay(date: date, markedReminders: reminders));
    }
    return days;
  }

  @override
  Future<void> markReminder(DateTime date, ReminderEntity reminder) async {
    final box = await _openBox();
    final key = _dateKey(date);
    List<String> reminderIds = List<String>.from(
      box.get(key, defaultValue: []),
    );
    if (!reminderIds.contains(reminder.id)) {
      reminderIds.add(reminder.id);
      await box.put(key, reminderIds);
    }
  }

  @override
  Future<void> unmarkReminder(DateTime date, String reminderId) async {
    final box = await _openBox();
    final key = _dateKey(date);
    List<String> reminderIds = List<String>.from(
      box.get(key, defaultValue: []),
    );
    reminderIds.remove(reminderId);
    await box.put(key, reminderIds);
  }
}
