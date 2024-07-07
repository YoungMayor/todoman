import 'package:flutter/material.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/screens/task_lists_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: const SharedPreferencesManager.hasSeenOnboarding().getBool(
          defaultValue: false,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return const TaskListsScreen();
            } else {
              return const OnboardingScreen();
            }
          }
        },
      ),
    );
  }
}
