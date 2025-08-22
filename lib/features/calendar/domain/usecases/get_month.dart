import '../../../../core/interfaces/calendar_repository.dart';
import '../entities/calendar_day.dart';

class GetMonth {
  final CalendarRepository repository;
  GetMonth(this.repository);

  Future<List<CalendarDay>> call(int year, int month) async {
    return await repository.getMonth(year, month);
  }
}
