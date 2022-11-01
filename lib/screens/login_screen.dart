import 'package:flutter/material.dart';

import '../providers/login_api_provider.dart';
import '../widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    String email = 'raul@gmail.com';
    String password = '123456';
    return Scaffold(
      backgroundColor: Colors.white,
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
                CustomInputField(key, 'User Email', 'Email', 'Insert Email'),
                const SizedBox(height: 20),
                CustomInputField(
                    key, 'User Password', 'Password', 'Insert Password'),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 50),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        fixedSize:
                            MaterialStateProperty.all(const Size(80, 30)),
                      ),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());

                        LoginApiProvider().postLogin(email, password);

                        //Navigator(),
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
