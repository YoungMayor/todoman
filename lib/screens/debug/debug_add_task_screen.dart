import 'package:flutter/material.dart';
import 'package:todoman/screens/add_task_screen.dart';

class DebugAddTaskScreen extends StatelessWidget {
  const DebugAddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug add task screen'),
      ),
      body: const AddTaskScreen(),
    );
  }
}
