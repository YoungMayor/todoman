import 'package:flutter/material.dart';
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          CustomTextFormField(
            controller: _todoTitleController,
            validator: (value) =>
                Validations(value: value).required().validate(),
            labelText: 'Title',
          ),
          CustomTextFormField(
            controller: _todoDescriptionController,
            validator: (value) =>
                Validations(value: value).required().validate(),
            labelText: 'Description',
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
            child: const Text('Submit'),
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
