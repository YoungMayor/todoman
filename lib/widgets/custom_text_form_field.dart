import 'package:flutter/material.dart';

typedef ValidatorFunction = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.labelText,
    this.prefixIcon = Icons.abc,
    this.verticalPadding = 15,
  });

  final TextEditingController controller;
  final ValidatorFunction validator;
  final String labelText;
  final IconData prefixIcon;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: TextFormField(
        autocorrect: true,
        controller: controller,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(prefixIcon),
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
