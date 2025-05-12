import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_example/repository/aouth_repository.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/utils/utils.dart';

class SignUpViewModel with ChangeNotifier {
  final _myRepo = AouthRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  // Obscure password
  bool _obscurePasswords = true;
  bool get obscurePasswords => _obscurePasswords;

  void togglePasswordVisibility() {
    _obscurePasswords = !_obscurePasswords;
    notifyListeners();
  }

  // Sign up loader
  bool _signUpLoader = false;
  bool get signUpLoader => _signUpLoader;
  // setter for Sign up loader

  void setLoginLoader(bool value) {
    _signUpLoader = value;
    notifyListeners();
  }

  // sign up verification
  bool validateSignUpForm(BuildContext context) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Utils.flushBarErrorMessage('Please fill all the fields.', context);
      return false;
    }

    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      Utils.flushBarErrorMessage(
          'Please enter a valid email address.', context);
      return false;
    }

    if (password.length < 6) {
      Utils.flushBarErrorMessage(
          'Password should be at least 6 characters long.', context);
      return false;
    }

    if (password != confirmPassword) {
      Utils.flushBarErrorMessage('Passwords do not match.', context);
      return false;
    }

    // If all validations pass, collect data and call the login API

    return true; // Valid
  }

  // sign up function
  Future<void> callSignUp(
    Map<String, String> data, {
    required VoidCallback onSuccess,
    required void Function(String error) onError,
    required VoidCallback onfailed,
  }) async {
    try {
      setLoginLoader(true);

      Response response = await _myRepo.regesterApi(data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];
        print("User token: $token");
        clearVirabls();
        onSuccess(); // ✅ Success callback
      } else {
        onfailed(); // ✅ Failure callback
      }
    } catch (error, stackTrace) {
      onError(error.toString()); // ✅ Error callback
    } finally {
      setLoginLoader(false);
    }
  }

  void signUp({
    required VoidCallback onSuccess,
    required VoidCallback onfailed,
    required void Function(String error) onError,
    required BuildContext content,
  }) {
    bool isValid = validateSignUpForm(content);
    Map<String, String> data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    if (isValid) {
      callSignUp(data,
          onSuccess: onSuccess, onError: onError, onfailed: onfailed);
    } else {
      return;
    }
  }

  void clearVirabls() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose(); // add this
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose(); // add this
    super.dispose();
  }
}
