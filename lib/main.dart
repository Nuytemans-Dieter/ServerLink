import 'package:flutter/material.dart';

void main() {
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {

  final String _appName = 'MC ServerLink';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this._appName,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}