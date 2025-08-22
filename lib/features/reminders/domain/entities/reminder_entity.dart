/// Representa un recordatorio definido por el usuario.
/// No depende de la base de datos ni de la interfaz.
/// Puede usarse tanto para almacenamiento local como remoto.
class ReminderEntity {
  final String id; // UUID o generado por la BD
  final String name;
  final int colorIndex; // índice en una lista predefinida de colores (0-4)

  const ReminderEntity({
    required this.id,
    required this.name,
    required this.colorIndex,
  });

  ReminderEntity copyWith({String? id, String? name, int? colorIndex}) {
    return ReminderEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      colorIndex: colorIndex ?? this.colorIndex,
    );
  }

  @override
  String toString() =>
      'ReminderEntity(id: $id, name: $name, colorIndex: $colorIndex)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          colorIndex == other.colorIndex;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ colorIndex.hashCode;
}
