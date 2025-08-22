import '../../features/settings/domain/entities/plan_entity.dart';

/// Contrato para la configuración global del usuario (plan activo, preferencias...).
abstract class SettingsRepository {
  /// Obtiene el plan actual del usuario.
  Future<PlanEntity> getCurrentPlan();

  /// Cambia el plan activo del usuario.
  Future<void> setCurrentPlan(PlanEntity plan);

  /// Reinicia la configuración a valores por defecto.
  Future<void> resetSettings();
}
