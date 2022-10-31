import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;

  const CustomInputField(
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        autofocus: true,
        validator: (value) {
          if (value == null) return 'Empty Fields';
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
