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
  late bool _isDone = widget.task.doneAt != null;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    AppDatabase database = Provider.of<AppDatabase>(context);
    NavigatorState navigator = Navigator.of(context);

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
          _isDone ? Icons.check_rounded : Icons.circle_outlined,
        ),
        trailing: IconButton(
          color: Colors.redAccent,
          icon: const Icon(Icons.delete_forever),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: const Text("Are you sure??"),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text("This will permanently delete this task."),
                      ),
                      Center(child: Text("This cannot be undone!")),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('No, Cancel'),
                      onPressed: () {
                        navigator.pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Yes, Delete'),
                      onPressed: () async {
                        await database.managers.tasks
                            .filter((f) => f.id.equals(widget.task.id))
                            .delete();

                        navigator.pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        onTap: () async {
          bool oldIsDone = _isDone;

          setState(() {
            _isDone = !_isDone;
          });

          await Future.delayed(const Duration(milliseconds: 250));

          database.managers.tasks
              .filter((f) => f.id.equals(widget.task.id))
              .update(
                (o) => o(
                  doneAt: oldIsDone
                      ? const drift.Value(null)
                      : drift.Value(DateTime.now()),
                  updatedAt: drift.Value(DateTime.now()),
                ),
              );
        },
      ),
    );
  }
}
