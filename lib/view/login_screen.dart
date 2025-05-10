import 'package:flutter/material.dart';
import 'package:mvvm_example/res/app_colors.dart';

import 'package:mvvm_example/res/components/round_butten.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void _login() {
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

  // If all validations pass, navigate to home
  Navigator.pushNamed(context, RouteNames.homeScreen);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 80, color: AppColors.icon),
                const SizedBox(height: 16),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  color: AppColors.cardBackground,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Email
                        TextFormField(
                          controller: _emailController,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.alternate_email, color: AppColors.icon),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.border),
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            Utils.fieldFocuseChange(
                                context, emailFocusNode, passwordFocusNode);
                          },
                        ),
                        const SizedBox(height: 16),
                        // Password
                        ValueListenableBuilder(
                          valueListenable: _obscurePassword,
                          builder: (context, value, child) {
                            return TextFormField(
                              controller: _passwordController,
                              focusNode: passwordFocusNode,
                              obscureText: value,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock, color: AppColors.icon),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    value ? Icons.visibility_off : Icons.visibility,
                                    color: AppColors.icon,
                                  ),
                                  onPressed: () {
                                    _obscurePassword.value = !value;
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: AppColors.border),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                FocusScope.of(context).unfocus();
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          title: "Login",
                          onPressed: () {
                            _login();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
