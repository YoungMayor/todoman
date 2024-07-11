import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text(
            "I am coming soon. I would include; About Us, FAQ, Help and Feedback, Delete Data, and subsequently dark theme, also, version would be below",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
