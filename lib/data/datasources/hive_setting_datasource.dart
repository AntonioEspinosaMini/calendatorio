import 'package:calendatorio/data/datasources/setting_datasource.dart';
import 'package:hive/hive.dart';

import '../../features/settings/domain/entities/plan_entity.dart';

class HiveSettingsDataSource implements SettingsDataSource {
  static const String boxName = 'settingsBox';
  static const String planKey = 'currentPlan';

  Future<Box> _openBox() async => await Hive.openBox(boxName);

  @override
  Future<PlanEntity> getCurrentPlan() async {
    final box = await _openBox();
    final value = box.get(planKey);
    if (value == null) {
      final freePlan = PlanEntity(
        id: 'free',
        name: 'Free',
        price: 0,
        maxReminders: 1,
        allowColors: false,
      );
      await box.put(planKey, {
        'id': freePlan.id,
        'name': freePlan.name,
        'price': freePlan.price,
        'maxReminders': freePlan.maxReminders,
        'allowColors': freePlan.allowColors,
      });
      return freePlan;
    }
    return PlanEntity(
      id: value['id'],
      name: value['name'],
      price: value['price'],
      maxReminders: value['maxReminders'],
      allowColors: value['allowColors'],
    );
  }

  @override
  Future<void> resetSettings() async {
    final box = await _openBox();
    await box.delete(planKey);
  }

  @override
  Future<void> setCurrentPlan(PlanEntity plan) async {
    final box = await _openBox();
    await box.put(planKey, {
      'id': plan.id,
      'name': plan.name,
      'price': plan.price,
      'maxReminders': plan.maxReminders,
      'allowColors': plan.allowColors,
    });
  }
}
