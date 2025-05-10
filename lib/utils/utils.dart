import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';

class Utils {
  // Static method to show a custom styled toast message
  static Future<bool?> toastMessage(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,       // Dark background
      textColor: Colors.white,               // Bright text for contrast
      fontSize: 16.0,                         // Readable font size
      toastLength: Toast.LENGTH_LONG,        // Display duration
      gravity: ToastGravity.BOTTOM,          // Position on screen
      timeInSecForIosWeb: 3                  // For iOS & Web
    );
  }

  // Static method to show a styled error flushbar message
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        icon: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        animationDuration: const Duration(milliseconds: 500),
        forwardAnimationCurve: Curves.easeIn,
      )..show(context),
    );
  }
}
