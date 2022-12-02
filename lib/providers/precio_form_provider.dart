import 'package:flutter/material.dart';

class PrecioFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  double precio = 0;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
