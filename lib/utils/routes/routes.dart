import 'package:flutter/material.dart';
import 'package:mvvm_example/utils/routes/routes_names.dart';

import 'package:mvvm_example/view/home_screen.dart'; // Import the Home screen widget
import 'package:mvvm_example/view/login_screen.dart';
import 'package:mvvm_example/view/sign_up_acreen.dart';
import 'package:mvvm_example/view/splash_screen.dart'; // Import the Login screen widget

// This class defines all the routes used in the app
class Routes {
  // This method returns the correct screen based on the route name
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Use a switch statement to match the route name
    switch (settings.name) {
      //splash screen
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext content) => SplashScreen());
      //  Route for Sign Up
      case RouteNames.signUpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());
      // Route for Home Screen
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              HomeScreen(), // Navigate to HomeScreen widget
        );

      // Route for Login Screen
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              LoginScreen(), // Navigate to LoginScreen widget
        );

      // Default route (if no match is found)
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              body: Center(
                child: Text(
                    "No route defined for ${settings.name}"), // Show error message
              ),
            );
          },
        );
    }
  }
}
