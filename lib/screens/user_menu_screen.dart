import 'package:flutter/material.dart';
import 'package:trabajo_flutter/providers/edit_form_provider.dart';
import 'package:trabajo_flutter/providers/user_form_provider.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserMenuScreen extends StatelessWidget {
  const UserMenuScreen({Key? key}) : super(key: key);

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
            const SizedBox(height: 360),
            Container(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('MENU', style: Theme.of(context).textTheme.headline4),
                ],
              ),
            ),
          ],
        ))));
  }
}
