import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final auth = FirebaseAuth.instance;
  final userStream = FirebaseAuth.instance.authStateChanges();
  IdTokenResult? _currentToken;

  Future<void> signOut() async {
    await auth.signOut();
    _currentToken = null;
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
