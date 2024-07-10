import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoman/screens/add_task_screen.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';
import 'package:todoman/database.dart' as db;
import 'package:todoman/widgets/task_item.dart';

class TaskListsScreen extends StatefulWidget {
  const TaskListsScreen({super.key});

  @override
  State<TaskListsScreen> createState() => _TaskListsScreenState();
}

class _TaskListsScreenState extends State<TaskListsScreen> {
  final List<db.Task> _tasks = [];

  final db.AppDatabase _database = db.AppDatabase();

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));

    List<db.Task> fetched = await _database.managers.tasks.get();

    setState(() {
      _tasks.clear();
      _tasks.addAll(fetched);
    });
  }

  @override
  void initState() {
    super.initState();

    refresh();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations? appLocale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocale.projectName,
          style: GoogleFonts.acme(
            textStyle: TextStyle(
              fontSize: 32,
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              const SharedPreferencesManager.hasSeenOnboarding().setBool(false);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const OnboardingScreen(),
              ));
            },
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Scaffold.of(context).showBottomSheet(
                  (BuildContext context) {
                    return const AddTaskScreen();
                  },
                  showDragHandle: true,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                );
              },
            );
          }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          itemBuilder: (context, index) => TaskItem(task: _tasks[index]),
          itemCount: _tasks.length,
        ),
      ),
    );
  }
}
