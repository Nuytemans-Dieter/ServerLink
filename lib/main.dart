import 'package:flutter/material.dart';
import 'package:server_link_client/user_interface/screen_holder.dart';

void main() {
  runApp(AppWrapper());
}

class AppWrapper extends StatelessWidget {

  final String _appName = 'ServerLink MC';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this._appName,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreenHolder(),
    );
  }
}