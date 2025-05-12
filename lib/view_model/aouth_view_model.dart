import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_example/repository/aouth_repository.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/utils/utils.dart';

class AouthViewModel with ChangeNotifier {
  final _myRepo = AouthRepository();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // login loader
  bool _loaderLogin = false; // Changed from final to non-final
  bool get loaderLogin => _loaderLogin;

  void setLoginLoader(bool value) {
    _loaderLogin = value;
    notifyListeners(); // Notify listeners when the value changes
  }

  // Obscure password
  final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  bool validateLoginForm(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Email Empty Check
    if (email.isEmpty) {
      Utils.flushBarErrorMessage("Please enter your email", context);
      return false;
    }

    // Email Format Check
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      Utils.flushBarErrorMessage("Please enter a valid email", context);
      return false;
    }

    // Password Empty Check
    if (password.isEmpty) {
      Utils.flushBarErrorMessage("Please enter your password", context);
      return false;
    }

    return true;
  }

  Future<void> callLogInApi(
      Map<String, String> data, BuildContext context) async {
    try {
      setLoginLoader(true); // Set loader to true when starting the API call

      // Attempting the login API call
      Response response = await _myRepo.loginApi(data);

      // If successful, print the response
      print("Response: ${response}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];
        // Navigator.pushNamed(context, RouteNames.homeScreen);
        Utils.showSnackBar("LogIn Successfully", context);
        Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
      }
    } catch (error, stackTrace) {
      // If an error occurs, print the error and stack trace
      print("Error: $error");
      print("Stack Trace: $stackTrace");
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoginLoader(
          false); // Reset loader after API call completes (success or failure)
    }
  }

  void login(BuildContext context) {
    bool isValid = validateLoginForm(context);
    Map<String, String> data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    if (isValid) {
      callLogInApi(data, context);
    } else {
      return;
    }
  }

  // Dispose of controllers and focus nodes
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
