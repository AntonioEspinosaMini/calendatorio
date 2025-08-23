import 'package:hive/hive.dart';
import '../../features/reminders/domain/entities/reminder_entity.dart';
import 'reminder_datasource.dart';
import 'package:uuid/uuid.dart';

class HiveReminderDataSource implements ReminderDataSource {
  static const String boxName = 'remindersBox';
  final Uuid _uuid = Uuid();

  Future<Box> _openBox() async => await Hive.openBox(boxName);

  @override
  Future<void> addReminder(ReminderEntity reminder) async {
    final box = await _openBox();
    final id = reminder.id.isEmpty ? _uuid.v4() : reminder.id;
    await box.put(id, {
      'name': reminder.name,
      'colorIndex': reminder.colorIndex,
      'repeatEveryDays': reminder.repeatEveryDays,
    });
  }

  @override
  Future<void> deleteReminder(String reminderId) async {
    final box = await _openBox();
    await box.delete(reminderId);
  }

  @override
  Future<List<ReminderEntity>> getAllReminders() async {
    final box = await _openBox();
    return box.keys.map((key) {
      final value = box.get(key);
      return ReminderEntity(
        id: key,
        name: value['name'],
        colorIndex: value['colorIndex'],
        repeatEveryDays: value['repeatEveryDays'],
      );
    }).toList();
  }

  @override
  Future<void> updateReminder(ReminderEntity reminder) async {
    final box = await _openBox();
    await box.put(reminder.id, {
      'name': reminder.name,
      'colorIndex': reminder.colorIndex,
      'repeatEveryDays': reminder.repeatEveryDays,
    });
  }
}
