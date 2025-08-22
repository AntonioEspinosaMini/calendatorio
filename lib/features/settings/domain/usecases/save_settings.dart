import 'package:calendatorio/features/settings/domain/entities/plan_entity.dart';

import '../../../../core/interfaces/settings_repository.dart';

class SaveSettings {
  final SettingsRepository repository;

  SaveSettings(this.repository);

  Future<void> call(PlanEntity settings) async {
    await repository.setCurrentPlan(settings);
  }
}
