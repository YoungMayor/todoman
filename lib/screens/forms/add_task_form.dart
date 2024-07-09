import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoman/utils/validations.dart';
import 'package:todoman/widgets/custom_text_form_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _todoTitleController = TextEditingController();
  final _todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocale = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextFormField(
            controller: _todoTitleController,
            validator: (value) =>
                Validations(value: value).required().validate(),
            labelText: appLocale.title,
          ),
          CustomTextFormField(
            controller: _todoDescriptionController,
            validator: (value) =>
                Validations(value: value).required().validate(),
            labelText: appLocale.description,
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

  void processForm(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();

    ScaffoldMessengerState messengerState = ScaffoldMessenger.of(context);

    if (isValid != true) {
      messengerState.showSnackBar(
        const SnackBar(
          content: Text('Form is invalid!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _todoTitleController.dispose();
    _todoDescriptionController.dispose();
    super.dispose();
  }
}
