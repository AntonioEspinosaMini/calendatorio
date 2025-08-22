import '../../features/settings/domain/entities/plan_entity.dart';

/// Datasource para configuración del usuario (plan activo, preferencias).
abstract class SettingsDataSource {
  Future<PlanEntity> getCurrentPlan();
  Future<void> setCurrentPlan(PlanEntity plan);
  Future<void> resetSettings();
}
