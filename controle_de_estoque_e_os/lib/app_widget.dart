import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Estoque e OS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    ).modular();
  }
}
