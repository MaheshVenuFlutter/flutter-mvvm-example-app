import 'package:flutter/material.dart';
import 'package:mvvm_example/repository/aouth_repository.dart';
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

  Future<void> logIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Email Empty Check
    if (email.isEmpty) {
      Utils.flushBarErrorMessage("Please enter your email", context);
      return;
    }

    // Email Format Check
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      Utils.flushBarErrorMessage("Please enter a valid email", context);
      return;
    }

    // Password Empty Check
    if (password.isEmpty) {
      Utils.flushBarErrorMessage("Please enter your password", context);
      return;
    }

    // If all validations pass, collect data and call the login API
    Map<String, String> data = {
      "email": email,
      "password": password,
    };

    // Call the API with the collected data
    callLogInApi(data, context);
  }

  Future<void> callLogInApi(Map<String, String> data, BuildContext context) async {
    try {
      setLoginLoader(true); // Set loader to true when starting the API call

      // Attempting the login API call
      var response = await _myRepo.loginApi(data);

      // If successful, print the response
      print("Response: $response");

      // You can handle navigation here, for example:
      // Navigator.pushNamed(context, RouteNames.homeScreen);
    } catch (error, stackTrace) {
      // If an error occurs, print the error and stack trace
      print("Error: $error");
      print("Stack Trace: $stackTrace");
      Utils.flushBarErrorMessage(error.toString(), context);
    } finally {
      setLoginLoader(false); // Reset loader after API call completes (success or failure)
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
