import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvvm_example/res/app_colors.dart';

import 'package:mvvm_example/res/components/round_butten.dart';

import 'package:mvvm_example/utils/utils.dart';
import 'package:mvvm_example/view_model/aouth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  void dispose() {
    // Dispose of the ViewModel
    context.read<AouthViewModel>().dispose();

    // Call the super.dispose() to ensure proper cleanup of the widget state
    super.dispose();
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
                      child: Consumer<AouthViewModel>(
                          builder: (context, provider, child) {
                        return Column(
                          children: [
                            // Email
                            TextFormField(
                              controller: provider.emailController,
                              focusNode: provider.emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.alternate_email,
                                    color: AppColors.icon),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: AppColors.border),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                Utils.fieldFocuseChange(
                                    context,
                                    provider.emailFocusNode,
                                    provider.passwordFocusNode);
                              },
                            ),
                            const SizedBox(height: 16),
                            // Password
                            ValueListenableBuilder(
                              valueListenable: _obscurePassword,
                              builder: (context, value, child) {
                                return TextFormField(
                                  controller: provider.passwordController,
                                  focusNode: provider.passwordFocusNode,
                                  obscureText: value,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon:
                                        Icon(Icons.lock, color: AppColors.icon),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColors.icon,
                                      ),
                                      onPressed: () {
                                        _obscurePassword.value = !value;

                                        context
                                            .read<AouthViewModel>()
                                            .togglePasswordVisibility();
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: AppColors.border),
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
                              loading: provider.loaderLogin,
                              onPressed: () {
                                context.read<AouthViewModel>().logIn(context);
                              },
                            )
                          ],
                        );
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
