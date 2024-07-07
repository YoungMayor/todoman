import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoman/screens/task_lists_screen.dart';
import 'package:todoman/utils/shared_preferences_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonText: 'Get Started',
        onFinish: () {
          const SharedPreferencesManager.hasSeenOnboarding().setBool(true);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => TaskListsScreen()),
          );
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: theme.colorScheme.primary,
        ),
        controllerColor: theme.colorScheme.secondary,
        totalPage: 3,
        headerBackgroundColor: theme.colorScheme.surface,
        pageBackgroundColor: theme.colorScheme.surface,
        background: const [
          OnboardingBackgroundImage(
            imagePath: 'assets/images/undraw/undraw_tasks.svg',
          ),
          OnboardingBackgroundImage(
            imagePath: 'assets/images/undraw/undraw_schedule.svg',
          ),
          OnboardingBackgroundImage(
            imagePath: 'assets/images/undraw/undraw_order_confirmed.svg',
          ),
        ],
        speed: 1.8,
        pageBodies: const [
          OnboardingBody(
            title: 'Welcome to TaskMaster',
            content:
                'Organise your tasks efficiently and get more done with TaskMaster. Stay productive and keep track of all your to-dos in one place.',
          ),
          OnboardingBody(
            title: 'Plan Your Day',
            content:
                'Easily plan your day by adding tasks and setting priorities. Never miss a deadline or forget an important task again.',
          ),
          OnboardingBody(
            title: 'Achieve Your Goals',
            content:
                'Track your progress and achieve your goals with TaskMaster. Your path to productivity starts here.',
          ),
        ],
      ),
    );
  }
}

class OnboardingBackgroundImage extends StatelessWidget {
  const OnboardingBackgroundImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      alignment: Alignment.bottomCenter,
      width: mediaQuery.size.width,
      height: mediaQuery.size.height * 0.4,
      child: SvgPicture.asset(
        imagePath,
        alignment: Alignment.bottomCenter,
        width: mediaQuery.size.width * 0.85,
        // height: mediaQuery.size.height * 0.4,
        fit: BoxFit.contain,
      ),
    );
  }
}

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key, required this.title, required this.content});

  final String title, content;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 30,
      ),
      child: Column(
        children: [
          SizedBox(
            height: mediaQuery.size.height * 0.4,
          ),
          Text(
            title,
            style: TextStyle(
              // @todo: Change font to something heavy
              color: theme.colorScheme.primary,
              fontSize: 36.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
