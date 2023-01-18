import 'package:flutter/material.dart';

import '../models/models.dart';

class UserFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User user;

  UserFormProvider(this.user);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
