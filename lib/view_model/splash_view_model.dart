import 'package:flutter/material.dart';
import 'package:mvvm_example/model/user_model.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/view_model/user_view_model.dart';

class SplashViewModel with ChangeNotifier {
  final UserViewModel _userViewModel = UserViewModel();

  Future<bool> isUserLoggedIn() async {
    try {
      UserModel user = await _userViewModel.getUser();
      return user.token != null && user.token!.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  void handleUserSession({
    required BuildContext context,
    required VoidCallback onLogin,
    required VoidCallback onLogout,
  }) async {
    await Future.delayed(const Duration(seconds: 3));
    bool loggedIn = await isUserLoggedIn();

    if (context.mounted) {
      if (loggedIn) {
        onLogin();
      } else {
        onLogout();
      }
    }
  }
}
