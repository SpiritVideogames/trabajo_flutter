import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/models.dart';
import '../providers/login_form_provider.dart';
import '../providers/register_form_provider.dart';
import '../services/login_services.dart';
import '../services/register_services.dart';
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
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Create account',
                    style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 10),
                ChangeNotifierProvider(
                  create: (_) => RegisterFormProvider(),
                  child: _RegisterForm(ciclesList),
                )
              ],
            )),
            const SizedBox(
              height: 50,
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
                    color: Colors.black54,
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
                  hintText: 'User name',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_circle)),
              onChanged: (value) => registerForm.name = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: 'User surname',
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_circle)),
              onChanged: (value) => registerForm.surname = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'User email',
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  border: OutlineInputBorder(),
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
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'User password',
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline_rounded)),
              onChanged: (value) => registerForm.password = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'User c_password',
                  labelText: 'Confirm password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline_rounded)),
              onChanged: (value) => registerForm.c_password = value,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  hintText: 'User cicle',
                  labelText: 'Cicle',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.auto_awesome_motion_sharp)),
              items: listOfCicles.map((e) {
                /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                return DropdownMenuItem(
                  child: Text(e.name.toString()),
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
                      Navigator.pushReplacementNamed(context, 'login');
                    } else {
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: 'ERROR',
                        desc: errorMessage,
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                            child: const Text(
                              "CLOSE",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ).show();
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
