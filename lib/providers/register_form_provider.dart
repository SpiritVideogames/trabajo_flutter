import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String c_password = '';
  String company_id = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
