import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeazeoshop/models/cart_model/cart_item_model.dart';
import 'package:zeazeoshop/models/user_model.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  void clear() {
    _sharedPrefs.clear();
  }

  UserModel? get user => _sharedPrefs.getString(_keyUser) != null
      ? UserModel.fromJson(jsonDecode(_sharedPrefs.getString(_keyUser) ?? ''))
      : null;

  set user(UserModel? value) {
    _sharedPrefs.setString(_keyUser, jsonEncode(value?.toJson()));
  }

  List<CartItemModel>? get cart => _sharedPrefs.get(_keyCart) != null
      ? (jsonDecode(_sharedPrefs.getString(_keyCart) ?? '') as List)
          .map((e) => CartItemModel.fromMap(e as Map<String, dynamic>))
          .toList()
      : null;

  set cart(List<CartItemModel>? value) {
    _sharedPrefs.setString(
      _keyCart,
      jsonEncode(value?.map((e) => e.toMap()).toList()),
    );
  }
}

const String _keyUser = "user";
const String _keyCart = "cart";
