import '../../features/settings/domain/entities/plan_entity.dart';

class PlansConstants {
  static const List<PlanEntity> availablePlans = [
    PlanEntity(
      id: "free",
      name: "Free",
      price: 0.0,
      maxReminders: 1,
      allowColors: false,
    ),
    PlanEntity(
      id: "basic",
      name: "Básico",
      price: 0.99,
      maxReminders: 3,
      allowColors: true,
    ),
    PlanEntity(
      id: "pro",
      name: "Pro",
      price: 1.99,
      maxReminders: 5,
      allowColors: true,
    ),
  ];
}
