import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoman/database.dart';
import 'package:todoman/screens/auth_protection_screen.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/screens/task_lists_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.purple,
  brightness: Brightness.light,
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.purple,
  brightness: Brightness.dark,
  useMaterial3: true,
);

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  String get themeLabel => switch (_themeMode) {
        ThemeMode.light => "Light",
        ThemeMode.dark => "Dark",
        ThemeMode.system => "System",
      };

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }

  void randomise() {
    ThemeMode currentTheme = themeMode;

    _themeMode = switch (currentTheme) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light
    };

    notifyListeners();
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system;

    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          title: 'TaskMaster',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('fr'), // French
          ],
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: FutureBuilder<bool>(
            future: const SharedPreferencesManager.hasSeenOnboarding().getBool(
              defaultValue: false,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.data == true) {
                  return AuthProtectionScreen.replaceAfter(
                    context: context,
                    page: const TaskListsScreen(),
                  );
                } else {
                  return const OnboardingScreen();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
