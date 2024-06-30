import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  static UserProvider of(
      BuildContext context,{bool listen=true,}){
    return Provider.of<UserProvider>(context,listen: listen);
  }
}

