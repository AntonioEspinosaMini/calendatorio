import 'package:flutter/material.dart';
import '../../domain/entities/plan_entity.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/save_settings.dart';

class SettingsController extends ChangeNotifier {
  final GetSettings getSettings;
  final SaveSettings saveSettings;

  PlanEntity? currentPlan;
  bool isLoading = false;

  SettingsController({required this.getSettings, required this.saveSettings});

  Future<void> loadPlan() async {
    isLoading = true;
    notifyListeners();

    currentPlan = await getSettings();
    isLoading = false;
    notifyListeners();
  }

  Future<void> changePlan(PlanEntity newPlan) async {
    isLoading = true;
    notifyListeners();

    await saveSettings(newPlan);
    currentPlan = newPlan;

    isLoading = false;
    notifyListeners();
  }
}
