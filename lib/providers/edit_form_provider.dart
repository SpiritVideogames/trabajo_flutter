import 'package:flutter/material.dart';

class EditFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String name = '';
  String surname = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
