import 'package:flutter/material.dart';
import '../../../../core/constants/app_theme.dart';
import '../../domain/entities/calendar_day.dart';

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay day;
  final VoidCallback onTap;
  final List<Color> colorPalette;

  const CalendarDayWidget({
    Key? key,
    required this.day,
    required this.onTap,
    required this.colorPalette,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grisClaro),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "${day.date.day}",
                style: const TextStyle(color: AppColors.azulGrisaceo),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 4,
              right: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: day.markedReminders.map((reminder) {
                  final color = colorPalette[reminder.colorIndex];
                  return Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
