import 'dart:async';

import 'package:controle_de_estoque_e_os/app_module.dart';
import 'package:controle_de_estoque_e_os/app_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    FirebaseAuth.instance.idTokenChanges().listen((event) {
      print(event);
    });
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print(user);
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(home: Text('Erro no firebase'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(home: AppWidgets());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class AppWidgets extends StatefulWidget {
  const AppWidgets({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidgets> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
          ),
          TextFormField(
            controller: passwordController,
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );
            },
            child: Text('Salvar'),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser?.reload();
              print(FirebaseAuth.instance.currentUser);
            },
            child: Text('Recarregar'),
          ),
          TextButton(
            onPressed: () async {
              print(FirebaseAuth.instance.currentUser);
              print(await FirebaseAuth.instance.currentUser
                  ?.getIdTokenResult(true));
            },
            child: Text('PegarToken'),
          ),
          TextButton(
            onPressed: () {
              print(FirebaseAuth.instance.currentUser);
              FirebaseAuth.instance.signOut();
            },
            child: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
