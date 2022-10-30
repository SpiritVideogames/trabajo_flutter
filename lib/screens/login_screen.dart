import 'package:flutter/material.dart';

import '../widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    String email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Form(
            key: myFormKey,
            child: Column(
              children: [
                const SizedBox(height: 100),
                CustomInputField(key, 'Email'),
                const SizedBox(height: 20),
                CustomInputField(key, 'Password'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (!myFormKey.currentState!.validate()) {
                      const Text('Incorrect Field');
                      return;
                    }
                    email = TextEditingController().text;
                    Text(email);
                    //Navigator(),
                  },
                  child: const Text('Submit'),
                ),
              ],
            )),
      ),
    );
  }
}
