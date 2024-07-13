import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoman/screens/add_task_screen.dart';
import 'package:todoman/database.dart';
import 'package:todoman/screens/settings_screen.dart';
import 'package:todoman/widgets/task_item.dart';

class TaskListsScreen extends StatelessWidget {
  const TaskListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    late final Stream<List<Task>> pendingTasksStream = database.managers.tasks
        .filter((f) => f.doneAt.isNull())
        .orderBy((o) => o.updatedAt.desc())
        .watch();

    late final Stream<List<Task>> completedTasksStream = database.managers.tasks
        .filter((f) => f.doneAt.not.isNull())
        .orderBy((o) => o.updatedAt.desc())
        .watch();

    return DefaultTabController(
      length: 2,
      animationDuration: Durations.long4,
      child: Scaffold(
        appBar: _TaskListAppBar(
          pendingStream: pendingTasksStream,
          completedStream: completedTasksStream,
        ),
        body: TabBarView(
          children: [
            _TaskListItems(stream: pendingTasksStream),
            _TaskListItems(stream: completedTasksStream),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Add Task'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog.adaptive(
                  content: const AddTaskScreen(),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  scrollable: true,
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class _TaskListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _TaskListAppBar({
    required this.pendingStream,
    required this.completedStream,
  });

  final Stream<List<Task>> pendingStream, completedStream;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations? appLocale = AppLocalizations.of(context)!;

    return AppBar(
      title: Text(
        appLocale.projectName,
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            fontSize: 32,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SettingsScreen(),
          )),
        )
      ],
      bottom: TabBar(
        tabs: [
          _tabWithCounter(
            stream: pendingStream,
            icon: Icons.hourglass_empty,
            prefix: "Pending",
          ),
          _tabWithCounter(
            stream: completedStream,
            icon: Icons.done,
            prefix: "Completed",
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<Task>> _tabWithCounter({
    required Stream<List<Task>> stream,
    required IconData icon,
    required String prefix,
  }) {
    return StreamBuilder<List<Task>>(
      stream: stream,
      builder: (context, snapshot) {
        int count = 0;
        if (snapshot.hasData && snapshot.data != null) {
          count = snapshot.data!.length;
        }

        return Tab(
          icon: Icon(icon),
          text: count > 0 ? "$prefix ($count)" : prefix,
        );
      },
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
          itemBuilder: (context, index) => TaskItem(
            task: tasks[index],
            key: UniqueKey(),
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
