import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoman/screens/add_task_screen.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';
import 'package:todoman/database.dart';
import 'package:todoman/widgets/task_item.dart';

class TaskListsScreen extends StatelessWidget {
  const TaskListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const _TaskListAppBar(),
        body: TabBarView(
          children: [
            _TaskListItems(
              stream: database.managers.tasks
                  .filter((f) => f.doneAt.isNull())
                  .orderBy((o) => o.updatedAt.desc())
                  .watch(),
            ),
            _TaskListItems(
              stream: database.managers.tasks
                  .filter((f) => f.doneAt.not.isNull())
                  .orderBy((o) => o.updatedAt.desc())
                  .watch(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _TaskListAppBar();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations? appLocale = AppLocalizations.of(context)!;

    return AppBar(
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
      bottom: const TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.hourglass_empty),
            text: "In Progress",
          ),
          Tab(
            icon: Icon(Icons.done),
            text: "Completed",
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kBottomNavigationBarHeight);
}

class _TaskListItems extends StatelessWidget {
  const _TaskListItems({required this.stream});

  final Stream<List<Task>> stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data ?? [];

        if (tasks.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64),
                SizedBox(height: 16),
                Text("Nothing here yet..."),
              ],
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) => TaskItem(task: tasks[index]),
          itemCount: tasks.length,
        );
      },
    );
  }
}
