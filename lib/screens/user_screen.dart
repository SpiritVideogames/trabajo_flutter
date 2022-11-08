import 'package:flutter/material.dart';
import 'package:trabajo_flutter/providers/edit_form_provider.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Text('EDITING USER',
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 10),
                ChangeNotifierProvider(
                  create: (_) => EditFormProvider(),
                  child: _EditForm(),
                ),
              ],
            )),
          ],
        ))));
  }
}

class _EditForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final editForm = Provider.of<EditFormProvider>(context);
    final userService = Provider.of<UsersServices>(context);
    late List<Datum4> users = [];
    users = userService.user.cast<Datum4>();
    final n = users.length;
    print("Tamaño");
    print(n);

    return Form(
        key: editForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                // initialValue: users[0].name,
                decoration: const InputDecoration(
                  hintText: 'User email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => editForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '') ? null : 'Insert email';
                }),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              // initialValue: user[1].name,
              decoration: const InputDecoration(
                  hintText: 'User name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box_rounded)),
              onChanged: (value) => editForm.name = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: 'User surname',
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box_rounded)),
              onChanged: (value) => editForm.surname = value,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  fixedSize: MaterialStateProperty.all(
                      const Size(double.infinity, 30)),
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (editForm.isValidForm()) {
                    //Navigator.pushNamed(context, 'edit');
                  }
                },
                child: const Center(child: Text('Save')),
              ),
            ),
          ],
        ));
  }
}
