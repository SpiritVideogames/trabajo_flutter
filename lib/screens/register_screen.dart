import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cool_alert/cool_alert.dart';
import '../models/models.dart';

import '../providers/register_form_provider.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';
import '../screens/screens.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ciclesService = Provider.of<CiclesServices>(context);
    List<DataCicles> ciclesList = ciclesService.cicles.cast<DataCicles>();
    if (ciclesService.isLoading) return LoadingScreen();
    return Scaffold(
        backgroundColor: Colors.white,
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(
          children: [
            const SizedBox(height: 180),
            CardContainer(
                child: Container(
              width: 300,
              child: DecoratedBox(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                      const BoxShadow(
                        color: Colors.white,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      )
                    ]),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text('Create account',
                          style: TextStyle(
                              fontSize: 34,
                              color: Color.fromARGB(255, 18, 201, 159))),
                      const SizedBox(height: 10),
                      ChangeNotifierProvider(
                        create: (_) => RegisterFormProvider(),
                        child: _RegisterForm(ciclesList),
                      )
                    ],
                  ),
                ),
              ),
            )),
            const SizedBox(
              height: 5,
            ),
            TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.1)),
                    shape: MaterialStateProperty.all(StadiumBorder())),
                child: const Text(
                  'Have an account already?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 18, 201, 159),
                  ),
                ))
          ],
        ))));
  }
}

class _RegisterForm extends StatelessWidget {
  List<DataCicles> listOfCicles = [];
  _RegisterForm(List<DataCicles> ciclesList, {super.key}) {
    listOfCicles = ciclesList;
  }
  @override
  Widget build(BuildContext context) {
    final registerService = Provider.of<RegisterServices>(context);
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Form(
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: 'Your name',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelText: 'Name',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 18, 201, 159)),
                  ),
                  prefixIcon: Icon(Icons.account_circle,
                      color: Color.fromARGB(255, 18, 201, 159))),
              onChanged: (value) => registerForm.name = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'Please, enter your name';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: 'Your surname',
                  labelText: 'Surname',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 18, 201, 159)),
                  ),
                  prefixIcon: Icon(Icons.account_circle,
                      color: Color.fromARGB(255, 18, 201, 159))),
              onChanged: (value) => registerForm.surname = value,
              validator: (value) {
                return (value != null && value.length >= 1)
                    ? null
                    : 'Please, enter your surname';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Your email',
                  labelText: 'Email',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  prefixIcon: Icon(Icons.alternate_email_rounded,
                      color: Color.fromARGB(255, 18, 201, 159)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 18, 201, 159)),
                  ),
                ),
                onChanged: (value) => registerForm.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Please, insert a valid email';
                }),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Your password',
                  labelText: 'Password',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 18, 201, 159)),
                  ),
                  prefixIcon: Icon(Icons.lock_outline_rounded,
                      color: Color.fromARGB(255, 18, 201, 159))),
              onChanged: (value) => registerForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'Please, enter a valid password';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Confirm your password',
                  labelText: 'Password confirmation',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 18, 201, 159)),
                  ),
                  prefixIcon: Icon(Icons.lock_outline_rounded,
                      color: Color.fromARGB(255, 18, 201, 159))),
              onChanged: (value) => registerForm.c_password = value,
              validator: (value) {
                return (value != null && value == registerForm.password)
                    ? null
                    : 'Passwords doesn\'t match';
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  hintText: 'User cicle',
                  labelText: 'Cicle',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 18, 201, 159)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 18, 201, 159))),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 18, 201, 159)),
                  ),
                  prefixIcon: Icon(Icons.auto_awesome_motion_sharp,
                      color: Color.fromARGB(255, 18, 201, 159))),
              items: listOfCicles.map((e) {
                /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                return DropdownMenuItem(
                  child: Text(e.name.toString(),
                      style:
                          TextStyle(color: Color.fromARGB(255, 18, 201, 159))),
                  value: e.id,
                );
              }).toList(),
              onChanged: (value) {
                registerForm.cicle_id = value!;
              },
              validator: (value) {
                return (value != null && value != 0)
                    ? null
                    : 'Please, select a cicle';
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 18, 201, 159)),
                  fixedSize: MaterialStateProperty.all(
                      const Size(double.infinity, 30)),
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final registerService =
                      Provider.of<RegisterServices>(context, listen: false);
                  if (registerForm.isValidForm()) {
                    final String? errorMessage =
                        await registerService.postRegister(
                            registerForm.name,
                            registerForm.surname,
                            registerForm.email,
                            registerForm.password,
                            registerForm.c_password,
                            registerForm.cicle_id);

                    if (errorMessage == null) {
                      String? user_id = await RegisterServices().readId();
                      final confirmServices =
                          Provider.of<ConfirmServices>(context, listen: false);
                      confirmServices.postConfirm(user_id);
                      RegisterServices().logout();
                      Navigator.pushReplacementNamed(context, 'login');
                    } else {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: errorMessage,
                        borderRadius: 30,
                        loopAnimation: true,
                        confirmBtnColor: Colors.red,
                      );
                    }
                  }
                },
                child: const Center(child: Text('Register')),
              ),
            ),
          ],
        ));
  }
}
