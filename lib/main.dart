import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_flutter/providers/precio_form_provider.dart';
import 'package:trabajo_flutter/services/services.dart';

import 'router/app_routes.dart';
import 'services/user_service.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ActivateServices()),
      ChangeNotifierProvider(create: (_) => ArticleServices()),
      ChangeNotifierProvider(create: (_) => ArticlesServices()),
      ChangeNotifierProvider(create: (_) => CompaniesServices()),
      ChangeNotifierProvider(create: (_) => DeactivateServices()),
      ChangeNotifierProvider(create: (_) => DeleteServices()),
      ChangeNotifierProvider(create: (_) => FamiliesServices()),
      ChangeNotifierProvider(create: (_) => UserServices()),
      ChangeNotifierProvider(create: (_) => LoginServices()),
      ChangeNotifierProvider(create: (_) => LogoutServices()),
      ChangeNotifierProvider(create: (_) => OrdersServices()),
      ChangeNotifierProvider(create: (_) => ProductAddServices()),
      ChangeNotifierProvider(create: (_) => ProductDeleteServices()),
      ChangeNotifierProvider(create: (_) => ProductsCompanyServices()),
      ChangeNotifierProvider(create: (_) => RegisterServices()),
      ChangeNotifierProvider(create: (_) => UpdateServices()),
      ChangeNotifierProvider(create: (_) => UserServices()),
      ChangeNotifierProvider(create: (_) => UsersServices()),
      ChangeNotifierProvider(create: (_) => PrecioFormProvider()),
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
          primaryColor: const Color.fromARGB(197, 17, 193, 134),
          //appbar thme
          appBarTheme: AppBarTheme(
              color: Color.fromARGB(197, 17, 193, 134), elevation: 0)),
    );
  }
}
