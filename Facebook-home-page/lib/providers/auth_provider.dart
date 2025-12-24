import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _firebaseUser;
  UserModel? _userModel;

  User? get firebaseUser => _firebaseUser;
  UserModel? get userModel => _userModel;
  bool get isLoggedIn => _firebaseUser != null;

  AuthProvider() {
    _authService.authStateChanges().listen((u) async {
      _firebaseUser = u;
      if (u != null) {
        _userModel = await _authService.getCurrentUserModel();
      } else {
        _userModel = null;
      }
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    _userModel = await _authService.signIn(email: email, password: password);
    _firebaseUser = _authService.currentUser;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    _userModel =
        await _authService.signUp(name: name, email: email, password: password);
    _firebaseUser = _authService.currentUser;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    _userModel = await _authService.signInWithGoogle();
    _firebaseUser = _authService.currentUser;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
