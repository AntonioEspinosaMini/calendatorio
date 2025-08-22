import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/reminder_controller.dart';
import '../widgets/reminder_card.dart';
import '../../domain/entities/reminder_entity.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late RemindersController controller;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      controller = context.read<RemindersController>();
      controller.loadReminders();
      _isLoaded = true;
    }
  }

  void _openReminderDialog({ReminderEntity? reminder}) {
    showDialog(
      context: context,
      builder: (_) =>
          _ReminderDialog(controller: controller, reminder: reminder),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recordatorios")),
      body: Consumer<RemindersController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.reminders.isEmpty) {
            return const Center(child: Text("No hay recordatorios aún"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.reminders.length,
            itemBuilder: (context, index) {
              final reminder = controller.reminders[index];
              return ReminderCard(
                reminder: reminder,
                onDelete: () => controller.removeReminder(reminder.id),
                onTap: () => _openReminderDialog(reminder: reminder),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openReminderDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Modal único para añadir o editar recordatorio
class _ReminderDialog extends StatefulWidget {
  final RemindersController controller;
  final ReminderEntity? reminder; // Si es null -> añadir

  const _ReminderDialog({required this.controller, this.reminder});

  @override
  State<_ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<_ReminderDialog> {
  late TextEditingController _nameController;
  late TextEditingController _daysController;
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reminder?.name ?? '');
    _daysController = TextEditingController(
      text: widget.reminder?.repeatEveryDays.toString() ?? '1',
    );
    _selectedColorIndex = widget.reminder?.colorIndex ?? 0;
  }

  Widget build(BuildContext context) {
    final isEditing = widget.reminder != null;

    final _formKey = GlobalKey<FormState>();

    return AlertDialog(
      title: Text(isEditing ? "Editar recordatorio" : "Añadir recordatorio"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "El nombre es obligatorio";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text("Se cumple cada "),
                SizedBox(
                  width: 50, // ancho fijo para el número
                  child: TextFormField(
                    controller: _daysController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final number = int.tryParse(value ?? '');
                      if (number == null || number < 1) return '≥ 1';
                      return null;
                    },
                  ),
                ),
                const Text(" día(s)"),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: List.generate(kReminderColors.length, (index) {
                final color = kReminderColors[index];
                return GestureDetector(
                  onTap: () => setState(() => _selectedColorIndex = index),
                  child: CircleAvatar(
                    backgroundColor: color,
                    child: _selectedColorIndex == index
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final reminder = ReminderEntity(
                id:
                    widget.reminder?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                name: _nameController.text.trim(),
                repeatEveryDays: int.parse(_daysController.text),
                colorIndex: _selectedColorIndex,
              );

              if (isEditing) {
                widget.controller.modifyReminder(reminder);
              } else {
                widget.controller.addNewReminder(reminder);
              }

              Navigator.pop(context);
            }
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
