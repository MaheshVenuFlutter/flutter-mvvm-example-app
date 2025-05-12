import 'package:flutter/material.dart';
import 'package:mvvm_example/res/app_colors.dart';
import 'package:mvvm_example/res/components/round_butten.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/utils/utils.dart';
import 'package:mvvm_example/view_model/aouth_view_model.dart';
import 'package:mvvm_example/view_model/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void dispose() {
    // Dispose of the ViewModel
    context.read<SignUpViewModel>().dispose();

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
                Icon(Icons.person_add_alt_1_outlined,
                    size: 80, color: AppColors.icon),
                const SizedBox(height: 16),
                Text(
                  "Create a New Account",
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
                    child: Consumer<SignUpViewModel>(
                      builder: (context, provider, child) {
                        return Column(
                          children: [
                            // Full Name
                            TextFormField(
                              controller: provider.nameController,
                              focusNode: provider.nameFocusNode,
                              decoration: InputDecoration(
                                labelText: "Full Name",
                                prefixIcon:
                                    Icon(Icons.person, color: AppColors.icon),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: AppColors.border),
                                ),
                              ),
                              onFieldSubmitted: (value) {
                                Utils.fieldFocuseChange(
                                  context,
                                  provider.nameFocusNode,
                                  provider.emailFocusNode,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
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
                                  provider.passwordFocusNode,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            // Confirm Password
                            Consumer<SignUpViewModel>(
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    TextFormField(
                                      controller: provider.passwordController,
                                      focusNode: provider.passwordFocusNode,
                                      obscureText: value.obscurePasswords,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        prefixIcon: Icon(Icons.lock,
                                            color: AppColors.icon),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            value.obscurePasswords
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.icon,
                                          ),
                                          onPressed: () {
                                            value.togglePasswordVisibility();
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.border),
                                        ),
                                      ),
                                      onFieldSubmitted: (value) {
                                        Utils.fieldFocuseChange(
                                          context,
                                          provider.passwordFocusNode,
                                          provider.confirmPasswordFocusNode,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller:
                                          provider.confirmPasswordController,
                                      focusNode:
                                          provider.confirmPasswordFocusNode,
                                      obscureText: value.obscurePasswords,
                                      decoration: InputDecoration(
                                        labelText: "Confirm Password",
                                        prefixIcon: Icon(Icons.lock,
                                            color: AppColors.icon),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            value.obscurePasswords
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: AppColors.icon,
                                          ),
                                          onPressed: () {
                                            value.togglePasswordVisibility();
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.border),
                                        ),
                                      ),
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            PrimaryButton(
                              title: "Sign Up",
                              loading: provider.signUpLoader,
                              onPressed: () {
                                context.read<SignUpViewModel>().signUp(
                                      content: context,
                                      onError: (error) {
                                        Utils.flushBarErrorMessage(
                                            error.toString(), context);
                                      },
                                      onSuccess: () {
                                        if (!context.mounted) return;
                                        Utils.showSnackBar(
                                            "User Created Successfully",
                                            context);
                                        Navigator.pushReplacementNamed(
                                            context, RouteNames.homeScreen);
                                      },
                                      onfailed: () {
                                        Utils.flushBarErrorMessage(
                                            "Signup failed", context);
                                      },
                                    );
                              },
                            ),
                          ],
                        );
                      },
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
