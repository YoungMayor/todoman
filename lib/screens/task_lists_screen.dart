import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoman/screens/add_task_screen.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';

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
        backgroundColor: theme.colorScheme.primaryContainer,
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
    );
  }
}
