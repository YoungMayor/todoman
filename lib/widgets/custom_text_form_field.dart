import 'package:flutter/material.dart';

typedef ValidatorFunction = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.labelText,
    this.prefixIcon,
    this.verticalPadding = 15,
    this.disabled = false,
  });

  final TextEditingController controller;
  final ValidatorFunction validator;
  final String labelText;
  final IconData? prefixIcon;
  final double verticalPadding;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: TextFormField(
        autocorrect: true,
        enabled: !disabled,
        controller: controller,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
