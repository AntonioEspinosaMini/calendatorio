import 'package:flutter/material.dart';
import '../../domain/entities/plan_entity.dart';

class PlanCard extends StatelessWidget {
  final PlanEntity plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard({
    Key? key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xFF36C1A2); // verde turquesa principal

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: primaryColor, width: 2) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre y check
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? primaryColor : Colors.black87,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: primaryColor, size: 24),
              ],
            ),
            const SizedBox(height: 12),

            // Precio
            Text(
              plan.price == 0
                  ? "Gratis"
                  : "\$${plan.price.toStringAsFixed(2)} / mes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),

            // Características
            Row(
              children: [
                Icon(Icons.notifications, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  "${plan.maxReminders} recordatorios",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 16),
                if (plan.allowColors)
                  Row(
                    children: [
                      Icon(Icons.color_lens, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        "Colores",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
