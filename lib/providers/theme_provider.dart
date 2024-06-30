import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  void toggleTheme(bool value,User user) {
    isDark = value;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .update({'isDark': isDark});
    notifyListeners();
  }

  Future<void> getThemePreference(User user) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .get();
    final isDark = userDoc['isDark'] as bool;
    toggleTheme(isDark,user);
  }


  static ThemeProvider of(
      BuildContext context,{bool listen=false,}){
    return Provider.of< ThemeProvider>(context,listen: listen);
  }
}
