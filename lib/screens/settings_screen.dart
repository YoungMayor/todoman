import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoman/screens/settings/about_us_screen.dart';
import 'package:todoman/screens/settings/delete_data_screen.dart';
import 'package:todoman/screens/settings/faq_screen.dart';
// import 'package:todoman/screens/settings/help_and_feedback_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List<(String, IconData, Widget)> settingMenuItems = [
    ("About us", Icons.info_outline, const AboutUsScreen()),
    ("Frequently Asked Questions", Icons.question_mark, FAQScreen()),
    // ("Help & Feedback", Icons.feedback_outlined, const HelpAndFeedbackScreen()),
    ("Delete Data", Icons.delete_outline_rounded, const DeleteDataScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppLocalizations? appLocale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: FlutterLogo(
              size: 160,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                appLocale.projectName,
                style: GoogleFonts.acme(
                  textStyle: TextStyle(
                    fontSize: 32,
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: settingMenuItems.length,
              itemBuilder: (context, index) {
                (String, IconData, Widget) settingItem =
                    settingMenuItems[index];

                return ListTile(
                  title: Text(settingItem.$1),
                  leading: Icon(settingItem.$2),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => settingItem.$3,
                    ));
                  },
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
