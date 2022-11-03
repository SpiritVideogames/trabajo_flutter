import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_flutter/providers/login_api_provider.dart';
import 'package:trabajo_flutter/services/users_services.dart';

import 'router/app_routes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UsersServices()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AlmaGest',
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.getAppRoutes(),
      theme: ThemeData.light().copyWith(
          //Color primario
          scaffoldBackgroundColor: Colors.grey[300],
          primaryColor: const Color.fromRGBO(0, 153, 153, 1),
          //appbar thme
          appBarTheme: const AppBarTheme(
              color: Color.fromRGBO(0, 153, 153, 1), elevation: 0)),
    );
  }
}
