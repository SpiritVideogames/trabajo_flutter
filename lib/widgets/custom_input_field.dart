import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? s;

  const CustomInputField(Key? key, this.s) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: s,
        ),
      ),
    );
  }
}
