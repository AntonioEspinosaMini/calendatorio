import 'package:calendatorio/features/settings/domain/entities/plan_entity.dart';

import '../../../../core/interfaces/settings_repository.dart';

class GetSettings {
  final SettingsRepository repository;

  GetSettings(this.repository);

  Future<PlanEntity> call() async {
    return await repository.getCurrentPlan();
  }
}
