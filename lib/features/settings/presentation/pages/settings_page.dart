import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/settings_controller.dart';
import '../widgets/plan_card.dart';
import '../../domain/entities/plan_entity.dart';

class SettingsPage extends StatelessWidget {
  final List<PlanEntity> availablePlans;

  const SettingsPage({super.key, required this.availablePlans});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize:
              MainAxisSize.min, // 🔹 Hace que el modal se ajuste al contenido
          children: [
            const Text(
              "Planes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C6A7D),
              ),
            ),
            const SizedBox(height: 16),
            controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true, // 🔹 Esto evita que intente crecer
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: availablePlans.length,
                    itemBuilder: (context, index) {
                      final plan = availablePlans[index];
                      final isSelected =
                          controller.currentPlan?.name == plan.name;

                      return PlanCard(
                        plan: plan,
                        isSelected: isSelected,
                        onTap: () => controller.changePlan(plan),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
