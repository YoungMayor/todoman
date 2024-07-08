import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoman/screens/forms/add_task_form.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(30),
      width: mediaQuery.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create a todo',
            style: GoogleFonts.acme(
              textStyle: TextStyle(
                fontSize: 32,
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const AddTaskForm(),
        ],
      ),
    );
  }
}
