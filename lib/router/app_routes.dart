import 'package:flutter/material.dart';
import 'package:trabajo_flutter/screens/index_adminStu_screen.dart';

import '../models/models.dart';

import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'Login';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'login',
        name: 'Login Screen',
        screen: LoginScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'register',
        name: 'Register Screen',
        screen: const RegisterScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'index',
        name: 'Index Screen',
        screen: IndexScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'index2',
        name: 'Index Screen',
        screen: Index2Screen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'edit',
        name: 'Edit Screen',
        screen: const EditScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'user',
        name: 'User Screen',
        screen: const UserScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'userCompany',
        name: 'User Company Screen',
        screen: const UserCompanyScreen(),
        icon: Icons.account_balance_outlined),
    MenuOption(
        route: 'load',
        name: 'Loadig Screen',
        screen: const LoadingScreen(),
        icon: Icons.account_balance_outlined),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final options in menuOptions) {
      appRoutes
          .addAll({options.route: (BuildContext context) => options.screen});
    }

    return appRoutes;
  }

  //static Map<String, Widget Function(BuildContext)> routes = {
  // 'home': (BuildContext context) => const HomeScreen(),
  //'listview1': (BuildContext context) => const Listview1Screen(),
  //'listview2': (BuildContext context) => const Listview2Screen(),
  //'alert': (BuildContext context) => const AlertScreen(),
  //'card': (BuildContext context) => const CardScreen(),
  // };

  static Route<dynamic> onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
