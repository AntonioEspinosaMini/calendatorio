import '../../core/interfaces/settings_repository.dart';
import '../../features/settings/domain/entities/plan_entity.dart';
import '../datasources/setting_datasource.dart';

/// Implementación de SettingsRepository usando un datasource concreto.
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource dataSource;

  SettingsRepositoryImpl({required this.dataSource});

  @override
  Future<PlanEntity> getCurrentPlan() async {
    return await dataSource.getCurrentPlan();
  }

  @override
  Future<void> resetSettings() async {
    await dataSource.resetSettings();
  }

  @override
  Future<void> setCurrentPlan(PlanEntity plan) async {
    await dataSource.setCurrentPlan(plan);
  }
}
