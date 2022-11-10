import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_flutter/services/services.dart';

import 'router/app_routes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ActivateServices()),
      ChangeNotifierProvider(create: (_) => AppliedServices()),
      ChangeNotifierProvider(create: (_) => CiclesServices()),
      ChangeNotifierProvider(create: (_) => ConfirmServices()),
      ChangeNotifierProvider(create: (_) => DeactivateServices()),
      ChangeNotifierProvider(create: (_) => DeleteServices()),
      ChangeNotifierProvider(create: (_) => LoginServices()),
      ChangeNotifierProvider(create: (_) => LogoutServices()),
      ChangeNotifierProvider(create: (_) => OffersAppliedServices()),
      ChangeNotifierProvider(create: (_) => OffersNotAppliedServices()),
      ChangeNotifierProvider(create: (_) => UsersServices()),
      ChangeNotifierProvider(create: (_) => UnappliedServices()),
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
