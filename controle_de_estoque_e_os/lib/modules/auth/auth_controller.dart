import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final auth = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  IdTokenResult? _currentToken;

  AuthController() {
    print('authController instantiation');
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<String?> getToken() async {
    if (_currentToken?.expirationTime?.isAfter(DateTime.now()) == true) {
      return _currentToken?.token;
    } else {
      _currentToken = await auth.currentUser?.getIdTokenResult();
      return _currentToken?.token;
    }
  }
}
