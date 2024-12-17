import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  Map<String, String> user;

  UserProvider({required this.user});

  void loginUser({
    required Map<String, String> enterUser,
  }) async {
    user = enterUser;
    notifyListeners();
  }
}
