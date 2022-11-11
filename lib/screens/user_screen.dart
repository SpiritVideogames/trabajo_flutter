import 'package:flutter/material.dart';
import 'package:trabajo_flutter/providers/edit_form_provider.dart';
import 'package:trabajo_flutter/providers/user_form_provider.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Navigator.restorablePushReplacementNamed(context, 'user');
    final usersService = Provider.of<UserServices>(context);
    if (usersService.isLoading) return LoadingScreen();
    return Scaffold(
        backgroundColor: Colors.white,
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('PROFILE', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 10),
                ChangeNotifierProvider(
                    create: (_) => EditFormProvider(),
                    child: _UserForm(
                      usersServices: usersService,
                    )),
              ],
            )),
          ],
        ))));
  }
}

class _UserForm extends StatelessWidget {
  final UserServices usersServices;

  const _UserForm({super.key, required this.usersServices});
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<EditFormProvider>(context);

    print('hola');
    print(usersServices.selectedUser.email);
    DataUser user = usersServices.selectedUser;
    // final user = userForm.user;
    //print("Tamaño");
    // print(n);

    //print(user.name);
    return Form(
        key: userForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                initialValue: user.email,
                decoration: const InputDecoration(
                  hintText: 'User email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => user.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '') ? null : 'Insert email';
                }),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              initialValue: user.name,
              decoration: const InputDecoration(
                  hintText: 'User name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box_rounded)),
              onChanged: (value) => user.name = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              initialValue: user.surname,
              decoration: const InputDecoration(
                  hintText: 'User surname',
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box_rounded)),
              onChanged: (value) => user.surname = value,
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
