import 'package:calendatorio/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/constants/plans.dart';
import 'data/datasources/hive_calendar_datasource.dart';
import 'data/datasources/hive_reminder_datasource.dart';
import 'data/datasources/hive_setting_datasource.dart';
import 'data/repositories/calendar_repository_impl.dart';
import 'data/repositories/reminder_repository_impl.dart';
import 'data/repositories/setting_repository_impl.dart';
import 'features/calendar/presentation/controllers/calendar_controller.dart';
import 'features/calendar/presentation/pages/calendar_page.dart';
import 'features/info/presentation/pages/info_page.dart';
import 'features/reminders/presentation/controllers/reminder_controller.dart';
import 'features/reminders/presentation/pages/reminder_page.dart';
import 'features/settings/domain/usecases/get_settings.dart';
import 'features/settings/domain/usecases/save_settings.dart';
import 'features/settings/presentation/controllers/settings_controller.dart';
import 'features/settings/presentation/pages/settings_page.dart';
import 'features/calendar/domain/usecases/get_month.dart';
import 'features/calendar/domain/usecases/mark_reminder.dart';
import 'features/calendar/domain/usecases/unmark_reminder.dart';
import 'features/calendar/domain/usecases/clear_reminder_from_calendar.dart';
import 'features/reminders/domain/usecases/get_all_reminders.dart';
import 'features/reminders/domain/usecases/add_reminder.dart';
import 'features/reminders/domain/usecases/update_reminder.dart';
import 'features/reminders/domain/usecases/delete_reminder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Hive para Flutter
  await Hive.initFlutter();

  // Abre las cajas necesarias
  await Hive.openBox('remindersBox');
  await Hive.openBox('calendarBox');
  await Hive.openBox('settingsBox');

  // Inicialización de datasources
  final reminderDataSource = HiveReminderDataSource();
  final calendarDataSource = HiveCalendarDataSource();
  final settingsDataSource = HiveSettingsDataSource();

  // Inicialización de repositorios
  final reminderRepository = ReminderRepositoryImpl(
    dataSource: reminderDataSource,
  );
  final calendarRepository = CalendarRepositoryImpl(
    dataSource: calendarDataSource,
  );
  final settingsRepository = SettingsRepositoryImpl(
    dataSource: settingsDataSource,
  );

  runApp(
    MultiProvider(
      providers: [
        // Casos de uso
        // Settings
        Provider(create: (_) => GetSettings(settingsRepository)),
        Provider(create: (_) => SaveSettings(settingsRepository)),

        // Reminders
        Provider(create: (_) => GetAllReminders(reminderRepository)),
        Provider(create: (_) => AddReminder(reminderRepository)),
        Provider(create: (_) => UpdateReminder(reminderRepository)),
        Provider(create: (_) => DeleteReminder(reminderRepository)),

        // Calendar
        Provider(create: (_) => GetMonth(calendarRepository)),
        Provider(create: (_) => MarkReminder(calendarRepository)),
        Provider(create: (_) => UnmarkReminder(calendarRepository)),
        Provider(create: (_) => ClearReminderFromCalendar(calendarRepository)),

        // Controllers (ChangeNotifier)
        ChangeNotifierProvider(
          create: (context) => CalendarController(
            getMonth: context.read<GetMonth>(),
            markReminder: context.read<MarkReminder>(),
            unmarkReminder: context.read<UnmarkReminder>(),
            clearReminder: context.read<ClearReminderFromCalendar>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RemindersController(
            getAllReminders: context.read<GetAllReminders>(),
            addReminder: context.read<AddReminder>(),
            updateReminder: context.read<UpdateReminder>(),
            deleteReminder: context.read<DeleteReminder>(),
            calendarController: context.read<CalendarController>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsController(
            getSettings: context.read<GetSettings>(),
            saveSettings: context.read<SaveSettings>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> backgroundCallback(Uri? data) async {
  // Aquí podremos manejar acciones desde el widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendatorio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openFreemiumModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SettingsPage(availablePlans: PlansConstants.availablePlans),
      ),
    );
  }

  void _openInfoModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(width: double.infinity, child: const InfoPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final remindersController = context.watch<RemindersController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () =>
              _openInfoModal(context), // información a la izquierda
        ),
        title: const Text("Calendatorio"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.crown),
            onPressed: () =>
                _openFreemiumModal(context), // freemium a la derecha
          ),
        ],
      ),

      body: Column(
        children: [
          // Calendario
          SizedBox(
            height: 350,
            child: CalendarPage(
              allReminders: remindersController.reminders,
              colorPalette: kReminderColors,
            ),
          ),
          // Recordatorios
          Expanded(child: RemindersPage()),
        ],
      ),
    );
  }
}
