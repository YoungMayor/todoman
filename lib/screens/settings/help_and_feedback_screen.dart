import 'package:flutter/material.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  const HelpAndFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Feedback"),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
