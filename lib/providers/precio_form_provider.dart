import 'package:flutter/material.dart';

class PrecioFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String precio = '';

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
