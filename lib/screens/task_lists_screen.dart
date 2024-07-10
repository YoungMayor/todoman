import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoman/screens/add_task_screen.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';
import 'package:todoman/database.dart';
import 'package:todoman/widgets/task_item.dart';

// class TaskListsScreen extends StatefulWidget {
//   const TaskListsScreen({super.key});

//   @override
//   State<TaskListsScreen> createState() => _TaskListsScreenState();
// }

class TaskListsScreen extends StatelessWidget {
  const TaskListsScreen({super.key});

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
      body: const TaskListItems(),
    );
  }
}

class TaskListItems extends StatelessWidget {
  const TaskListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder<List<Task>>(
      stream: database.managers.tasks.watch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        print("loadded");

        final tasks = snapshot.data ?? [];

        return ListView.builder(
          itemBuilder: (context, index) => TaskItem(task: tasks[index]),
          itemCount: tasks.length,
        );
      },
    );
  }
}
