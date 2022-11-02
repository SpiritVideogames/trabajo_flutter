import 'package:flutter/material.dart';

import 'router/app_routes.dart';

void main() => runApp(const MyApp());

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

          //appbar thme
          appBarTheme: const AppBarTheme(
              color: Color.fromRGBO(0, 153, 153, 1), elevation: 0)),
    );
  }
}
