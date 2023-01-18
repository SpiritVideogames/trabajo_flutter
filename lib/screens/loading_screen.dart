import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const Center(
          child: SpinKitWave(color: Color.fromRGBO(0, 153, 153, 1), size: 50)),
    );
  }
}
