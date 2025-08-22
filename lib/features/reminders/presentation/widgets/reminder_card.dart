import 'package:calendatorio/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/reminder_entity.dart';

class ReminderCard extends StatelessWidget {
  final ReminderEntity reminder;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ReminderCard({
    Key? key,
    required this.reminder,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: kReminderColors[reminder.colorIndex],
        ),
        title: Text(reminder.name),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
