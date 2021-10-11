import 'package:controle_de_estoque_e_os/modules/auth/pages/login_page.dart';
import 'package:controle_de_estoque_e_os/modules/home/home_page_signed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        print('user -> ${snapshot.data}');
        if (snapshot.data == null) {
          return LoginPage();
        }
        return HomePageSigned();
      },
    );
  }
}
