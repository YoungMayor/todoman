import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoman/database.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late final bool _isDone = widget.task.doneAt != null;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppDatabase database = Provider.of<AppDatabase>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          widget.task.title,
          style: TextStyle(
            decoration:
                _isDone ? TextDecoration.lineThrough : TextDecoration.none,
            color: _isDone
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          widget.task.content,
          style: TextStyle(
            decoration:
                _isDone ? TextDecoration.lineThrough : TextDecoration.none,
            color: _isDone
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        leading: Icon(
          _isDone ? Icons.check_rounded : Icons.check_box_outline_blank,
        ),
        onTap: () {
          database.managers.tasks
              .filter((f) => f.id.equals(widget.task.id))
              .update(
                (o) => o(
                  doneAt: _isDone
                      ? const drift.Value.absent()
                      : drift.Value(DateTime.now()),
                  updatedAt: drift.Value(DateTime.now()),
                ),
              );
        },
      ),
    );
  }
}
