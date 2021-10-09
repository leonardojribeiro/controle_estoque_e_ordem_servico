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
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final brightness = MediaQuery.of(context).platformBrightness;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Controle de Estoque e OS',
          theme: ThemeData(
            brightness: brightness,
            primarySwatch: Colors.blue,
          ),
        ).modular();
      },
    ).modular();
  }
}
