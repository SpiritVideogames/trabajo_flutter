import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? keyboardType;
  final bool obscureText;

  final String formProperty;
  final Map<String, String> formValues;

  const CustomInputField(
      Key? key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.keyboardType,
      this.obscureText,
      this.formProperty,
      this.formValues)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: (value) => formValues[formProperty] = value,
        autofocus: true,
        validator: (value) {
          if (value == null) return 'Empty Fields';
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
        ),
      ),
    );
  }
}
