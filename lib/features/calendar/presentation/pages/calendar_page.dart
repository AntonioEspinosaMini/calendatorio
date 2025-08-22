import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../reminders/domain/entities/reminder_entity.dart';
import '../../domain/entities/calendar_day.dart';
import '../controllers/calendar_controller.dart';
import '../widgets/calendar_widget.dart';

class CalendarPage extends StatefulWidget {
  final List<ReminderEntity> allReminders;
  final List<Color> colorPalette;

  const CalendarPage({
    super.key,
    required this.allReminders,
    required this.colorPalette,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CalendarController>().loadMonth(now.year, now.month);
    });
  }

  void _openDayModal(BuildContext context, CalendarDay day) {
    final calendarController = context.read<CalendarController>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Recordatorios del ${day.date.day}/${day.date.month}"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.allReminders.map((reminder) {
                final isMarked = day.markedReminders.any(
                  (r) => r.id == reminder.id,
                );

                return CheckboxListTile(
                  value: isMarked,
                  title: Text(reminder.name),
                  secondary: CircleAvatar(
                    backgroundColor: widget.colorPalette[reminder.colorIndex],
                  ),
                  onChanged: (_) async {
                    await calendarController.toggleReminder(day, reminder);
                    setState(() {}); // refrescar modal
                  },
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final calendarController = context.watch<CalendarController>();

    if (calendarController.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget buildDayWidget(DateTime day) {
      final rawDay = calendarController.days.firstWhere(
        (d) =>
            d.date.day == day.day &&
            d.date.month == day.month &&
            d.date.year == day.year,
        orElse: () => CalendarDay(date: day, markedReminders: []),
      );

      final fixedMarkedReminders = rawDay.markedReminders.map((r) {
        return widget.allReminders.firstWhere(
          (ar) => ar.id == r.id,
          orElse: () => r,
        );
      }).toList();

      final fixedDay = CalendarDay(
        date: rawDay.date,
        markedReminders: fixedMarkedReminders,
      );

      return CalendarDayWidget(
        day: fixedDay,
        onTap: () => _openDayModal(context, fixedDay),
        colorPalette: widget.colorPalette,
      );
    }

    return TableCalendar(
      firstDay: DateTime.utc(DateTime.now().year - 1),
      lastDay: DateTime.utc(DateTime.now().year + 1),
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      focusedDay: DateTime.now(),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) => buildDayWidget(day),
        todayBuilder: (context, day, _) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                234,
                234,
                234,
              ), // fondo gris suave para destacar el día
              borderRadius: BorderRadius.circular(
                6,
              ), // mantienes la forma redondeada
            ),
            child: buildDayWidget(day),
          );
        },
      ),
    );
  }
}
