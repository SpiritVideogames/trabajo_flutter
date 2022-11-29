import 'package:flutter/material.dart';
import 'package:trabajo_flutter/providers/edit_form_provider.dart';
import 'package:trabajo_flutter/providers/user_form_provider.dart';
import 'package:trabajo_flutter/screens/screens.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../services/user_service.dart';
import '../widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserCompanyScreen extends StatefulWidget {
  const UserCompanyScreen({Key? key}) : super(key: key);

  @override
  State<UserCompanyScreen> createState() => _UserCompanyScreenState();
}

class _UserCompanyScreenState extends State<UserCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    //Navigator.restorablePushReplacementNamed(context, 'user');
    //final userService = Provider.of<UserServices>(context);
    // if (userService.isLoading) return const LoadingScreen();
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.card_travel_rounded),
        onPressed: () {},
      ),
    ));
  }
}
