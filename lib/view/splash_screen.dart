import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm_example/res/app_colors.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';
import 'package:mvvm_example/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel _splashViewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    context.read<SplashViewModel>().handleUserSession(
          context: context,
          onLogin: () {
            Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
          },
          onLogout: () {
            Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flutter_dash, size: 100, color: AppColors.icon),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
