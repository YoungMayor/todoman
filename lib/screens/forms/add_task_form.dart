import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoman/database.dart';
import 'package:todoman/utils/validations.dart';
import 'package:todoman/widgets/custom_text_form_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextFormField(
            controller: _taskTitleController,
            validator: (value) =>
                Validations(value: value).required().validate(),
            labelText: appLocale.title,
            disabled: _processing,
          ),
          CustomTextFormField(
            controller: _taskDescriptionController,
            validator: (value) =>
                Validations(value: value).required().validate(),
            labelText: appLocale.description,
            disabled: _processing,
          ),
          FilledButton(
            style: const ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                ),
              ),
            ),
            onPressed: () => processForm(context),
            child: Text(appLocale.submit),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  void processForm(BuildContext context) async {
    if (_processing) {
      return _showSnackbar('Please wait');
    }

    if (_formKey.currentState!.validate() != true) {
      return _showSnackbar('Form is invalid');
    }

    try {
      setState(() => _processing = true);
      final database = AppDatabase();

      int taskId = await database.into(database.tasks).insert(
            TasksCompanion.insert(
              title: _taskTitleController.text,
              content: _taskDescriptionController.text,
            ),
          );

      _taskTitleController.clear();
      _taskDescriptionController.clear();

      _showSnackbar("Task #$taskId added successfully");
    } catch (e) {
      _showSnackbar("An error kinda occurred");

      rethrow;
    } finally {
      setState(() => _processing = false);
    }
  }

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
