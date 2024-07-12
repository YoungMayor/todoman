import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todoman/database.dart';
import 'package:todoman/screens/onboarding_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';

class DeleteDataScreen extends StatelessWidget {
  const DeleteDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    NavigatorState navigator = Navigator.of(context);
    AppDatabase database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Data?"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/undraw/undraw_throw_away.svg",
              alignment: Alignment.bottomCenter,
              width: 240,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Are you sure?",
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Text(
                "You have chosen to delete all your data from the application. This cannot be undone!",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      child: const Text('No, Go Back'),
                      onPressed: () {
                        navigator.pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.red.shade900),
                      ),
                      child: const Text('Yes, Delete'),
                      onPressed: () async {
                        const SharedPreferencesManager.hasSeenOnboarding()
                            .setBool(false);

                        await database.managers.tasks.delete();

                        navigator.pushReplacement(MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
