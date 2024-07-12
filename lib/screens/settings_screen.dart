import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todoman/main.dart';
import 'package:todoman/screens/settings/about_us_screen.dart';
import 'package:todoman/screens/settings/delete_data_screen.dart';
import 'package:todoman/screens/settings/faq_screen.dart';

void _pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => page,
  ));
}

void _randomiseTheme(BuildContext context) {
  ThemeProvider themeProvider =
      Provider.of<ThemeProvider>(context, listen: false);

  themeProvider.randomise();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("App Theme changed to ${themeProvider.themeLabel} mode"),
    ),
    snackBarAnimationStyle: AnimationStyle(duration: Durations.short4),
  );
}

typedef MenuItemCallback = void Function(BuildContext);

typedef SettingsMenuItem = (String, String?, IconData, MenuItemCallback);

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List<SettingsMenuItem> settingMenuItems = [
    (
      "About us",
      "Learn more about us...",
      Icons.info_outline,
      (context) => _pushPage(context, const AboutUsScreen())
    ),
    (
      "FAQs",
      "Check out our most Frequently Asked Questions...",
      Icons.question_mark,
      (context) => _pushPage(context, FAQScreen())
    ),
    (
      "Change Theme",
      null,
      Icons.light,
      (context) => _randomiseTheme(context),
    ),
    (
      "Delete Data",
      null,
      Icons.delete_outline_rounded,
      (context) => _pushPage(context, const DeleteDataScreen())
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/images/logo/7.svg",
              alignment: Alignment.bottomCenter,
              width: 320,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: settingMenuItems.length,
              itemBuilder: (context, index) {
                SettingsMenuItem settingItem = settingMenuItems[index];

                return ListTile(
                  title: Text(settingItem.$1),
                  subtitle:
                      settingItem.$2 != null ? Text(settingItem.$2!) : null,
                  leading: Icon(settingItem.$3),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => settingItem.$4(context),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                height: 20,
                thickness: 0.5,
                indent: 15,
                endIndent: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
