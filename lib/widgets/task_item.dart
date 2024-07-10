import 'package:flutter/material.dart';
import 'package:todoman/database.dart' as db;

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});

  final db.Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          widget.task.title,
          style: TextStyle(
            decoration:
                _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            color: _isChecked
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          widget.task.content,
          style: TextStyle(
            decoration:
                _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
            color: _isChecked
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        leading: Icon(
          _isChecked ? Icons.check_rounded : Icons.check_box_outline_blank,
        ),
        // trailing: Checkbox(
        //   shape: const CircleBorder(),
        //   value: _isChecked,
        //   onChanged: (bool? value) {},
        // ),
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
          });
        },
      ),
    );
  }
}
