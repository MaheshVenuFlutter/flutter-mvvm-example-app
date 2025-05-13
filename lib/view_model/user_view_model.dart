import 'package:flutter/material.dart';
import 'package:mvvm_example/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  bool _logOutLoader = false;
  bool get logOutLoader => _logOutLoader;

  void setLoginLoader(bool value) {
    _logOutLoader = value;
    notifyListeners();
  }

  Future<bool> saveUserData(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return UserModel(token: token);
  }

  Future<bool> removeUsr({
    required void Function() navigateTo,
  }) async {
    setLoginLoader(true);
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final result = await sp.clear();
    await Future.delayed(Duration(seconds: 2));

    setLoginLoader(false);
    navigateTo();

    notifyListeners();
    return result;
  }
}
