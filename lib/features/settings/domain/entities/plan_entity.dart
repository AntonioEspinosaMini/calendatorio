/// Representa un plan del modelo freemium.
/// Usado para determinar límites y funcionalidades habilitadas.
class PlanEntity {
  final String id; // "free", "basic", "pro"
  final String name;
  final double price; // en EUR
  final int maxReminders; // cantidad máxima de recordatorios
  final bool allowColors; // si permite usar colores personalizados

  const PlanEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.maxReminders,
    required this.allowColors,
  });

  bool isUnlimited() => maxReminders <= 0;

  PlanEntity copyWith({
    String? id,
    String? name,
    double? price,
    int? maxReminders,
    bool? allowColors,
  }) {
    return PlanEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      maxReminders: maxReminders ?? this.maxReminders,
      allowColors: allowColors ?? this.allowColors,
    );
  }

  @override
  String toString() =>
      'PlanEntity(id: $id, name: $name, price: $price, maxReminders: $maxReminders, allowColors: $allowColors)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          maxReminders == other.maxReminders &&
          allowColors == other.allowColors;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      maxReminders.hashCode ^
      allowColors.hashCode;
}
