import 'package:calendatorio/services/reminder_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import '../../../reminders/domain/entities/reminder_entity.dart';
import '../../domain/entities/calendar_day.dart';
import '../../domain/usecases/get_month.dart';
import '../../domain/usecases/mark_reminder.dart';
import '../../domain/usecases/unmark_reminder.dart';
import '../../domain/usecases/clear_reminder_from_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarController extends ChangeNotifier {
  final GetMonth getMonth;
  final MarkReminder markReminder;
  final UnmarkReminder unmarkReminder;
  final ClearReminderFromCalendar clearReminder;
  final ReminderNotificationService reminderNotificationService;

  List<CalendarDay> days = [];
  bool isLoading = false;

  CalendarController({
    required this.getMonth,
    required this.markReminder,
    required this.unmarkReminder,
    required this.clearReminder,
    required this.reminderNotificationService,
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

      notifyListeners();

      // Cancelamos notificacion
      if (reminder.notificationId != null) {
        await reminderNotificationService.cancelNotification(
          reminder.notificationId!,
        );
      }
    } else {
      await markReminder(day.date, reminder);
      day.markedReminders.add(reminder);

      notifyListeners();

      // Si hay notificación pendiente, se cancela
      if (reminder.notificationId != null) {
        await reminderNotificationService.cancelNotification(
          reminder.notificationId!,
        );
      }

      // Se crea nueva notificación
      // Calcula la fecha de notificación
      final scheduledDate = day.date.add(
        Duration(days: reminder.repeatEveryDays),
      );
      final scheduledTZDate = tz.TZDateTime.from(
        scheduledDate,
        tz.local,
      ).add(const Duration(hours: 12));

      if (scheduledTZDate.isAfter(tz.TZDateTime.now(tz.local))) {
        final newNotificationId = reminder.id.hashCode;
        unawaited(
          reminderNotificationService.scheduleNotification(
            newNotificationId,
            scheduledTZDate,
            reminder.name,
            'Recordatorio programado para ${scheduledTZDate.toLocal()}',
          ),
        );

        reminder = reminder.copyWith(notificationId: newNotificationId);
      }
    }

    await loadMonth(day.date.year, day.date.month);
  }

  Future<void> clearReminderFromAll(ReminderEntity reminder) async {
    isLoading = true;
    notifyListeners();

    await clearReminder(reminder.id);

    // Se cancela la notificación posible
    if (reminder.notificationId != null) {
      await reminderNotificationService.cancelNotification(
        reminder.notificationId!,
      );
    }

    if (days.isNotEmpty) {
      final year = days.first.date.year;
      final month = days.first.date.month;
      days = await getMonth(year, month);
    }

    isLoading = false;
    notifyListeners();
  }
}
