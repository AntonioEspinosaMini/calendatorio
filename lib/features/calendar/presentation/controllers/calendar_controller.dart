import 'package:flutter/material.dart';
import '../../../reminders/domain/entities/reminder_entity.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/usecases/get_month.dart';
import '../../domain/usecases/mark_reminder.dart';
import '../../domain/usecases/unmark_reminder.dart';
import '../../domain/usecases/clear_reminder_from_calendar.dart';

class CalendarController extends ChangeNotifier {
  final GetMonth getMonth;
  final MarkReminder markReminder;
  final UnmarkReminder unmarkReminder;
  final ClearReminderFromCalendar clearReminder;

  List<CalendarDay> days = [];
  bool isLoading = false;

  CalendarController({
    required this.getMonth,
    required this.markReminder,
    required this.unmarkReminder,
    required this.clearReminder,
  });

  Future<void> loadMonth(int year, int month) async {
    isLoading = true;
    notifyListeners();

    days = await getMonth(year, month);
    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleReminder(CalendarDay day, ReminderEntity reminder) async {
    if (day.markedReminders.any((r) => r.id == reminder.id)) {
      await unmarkReminder(day.date, reminder.id);
      day.markedReminders.removeWhere((r) => r.id == reminder.id);
    } else {
      await markReminder(day.date, reminder);
      day.markedReminders.add(reminder);
    }
    notifyListeners();
    await loadMonth(day.date.year, day.date.month);
  }

  Future<void> clearReminderFromAll(ReminderEntity reminder) async {
    isLoading = true;
    notifyListeners();

    await clearReminder(reminder.id);

    if (days.isNotEmpty) {
      final year = days.first.date.year;
      final month = days.first.date.month;
      days = await getMonth(year, month);
    }

    isLoading = false;
    notifyListeners();
  }
}
