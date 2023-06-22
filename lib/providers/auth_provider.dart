import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:zeazeoshop/models/user_model.dart';
import 'package:zeazeoshop/services/auth_service.dart';
import 'package:zeazeoshop/utils/shared_pref.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? name,
    String? username,
    String? email,
    String? password,
    String? phone,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
        phone: phone,
      );

      SharedPrefs().user = user;
      return true;
    } catch (e) {
      print('error register : $e');
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      SharedPrefs().user = user;
      return true;
    } catch (e) {
      print('error login : $e');
      return false;
    }
  }
}
