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
    if (usersService.isLoading) return const LoadingScreen();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: AuthBackground(
          child: SingleChildScrollView(
              child: Column(
        children: [
          const SizedBox(height: 200),
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
      ))),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(0, 204, 204, 1),
                  Color.fromRGBO(0, 153, 153, 1)
                ]),
              ),
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(0, 204, 204, 1),
                      Color.fromRGBO(0, 153, 153, 1)
                    ]),
                  ),
                  child: Stack(
                    children: [
                      Positioned(top: 90, left: 30, child: _Bubble()),
                      Positioned(top: -40, left: 20, child: _Bubble()),
                      Positioned(top: -50, right: -30, child: _Bubble()),
                      Positioned(bottom: -50, left: 15, child: _Bubble()),
                      Positioned(bottom: 90, right: 20, child: _Bubble()),
                    ],
                  )),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: Icon(Icons.logout_outlined),
              onTap: () {
                final logoutServices =
                    Provider.of<LoginServices>(context, listen: false);
                // Update the state of the app
                // ...
                // Then close the drawer
                logoutServices.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UserForm extends StatelessWidget {
  final UserServices usersServices;

  const _UserForm({super.key, required this.usersServices});
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<EditFormProvider>(context);

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
              initialValue: user.firstname,
              decoration: const InputDecoration(
                  hintText: 'User name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box_rounded)),
              onChanged: (value) => user.firstname = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              initialValue: user.secondname,
              decoration: const InputDecoration(
                  hintText: 'User surname',
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_box_rounded)),
              onChanged: (value) => user.secondname = value,
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}
