import 'package:flutter/material.dart';
import '../../../calendar/presentation/controllers/calendar_controller.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/usecases/add_reminder.dart';
import '../../domain/usecases/delete_reminder.dart';
import '../../domain/usecases/get_all_reminders.dart';
import '../../domain/usecases/update_reminder.dart';
import 'package:collection/collection.dart';

class RemindersController extends ChangeNotifier {
  final GetAllReminders getAllReminders;
  final AddReminder addReminder;
  final UpdateReminder updateReminder;
  final DeleteReminder deleteReminder;
  final CalendarController calendarController;

  List<ReminderEntity> reminders = [];
  bool isLoading = false;

  RemindersController({
    required this.getAllReminders,
    required this.addReminder,
    required this.updateReminder,
    required this.deleteReminder,
    required this.calendarController,
  });

  Future<void> loadReminders() async {
    isLoading = true;
    notifyListeners();

    reminders = await getAllReminders();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addNewReminder(ReminderEntity reminder) async {
    await addReminder(reminder);
    await loadReminders();
  }

  Future<void> removeReminder(String id) async {
    final reminder = reminders.firstWhereOrNull((r) => r.id == id);
    if (reminder == null) return;

    await calendarController.clearReminderFromAll(reminder);
    await deleteReminder(id);

    await loadReminders();
  }

  Future<void> modifyReminder(ReminderEntity reminder) async {
    await updateReminder(reminder);
    await loadReminders();
  }
}
