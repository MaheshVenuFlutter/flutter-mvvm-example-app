import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';

class Utils {
  
  /// Moves focus from the current field to the next.
  static void fieldFocuseChange(
      BuildContext context, FocusNode current, FocusNode next) {
        current.unfocus();
        FocusScope.of(context).requestFocus(next);
      }

  /// Shows a custom-styled toast message using `fluttertoast`
  static Future<bool?> toastMessage(String message) {
    return Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black87, // Dark background for visibility
        textColor: Colors.white, // White text for contrast
        fontSize: 16.0, // Readable text size
        toastLength: Toast.LENGTH_LONG, // Duration of toast
        gravity: ToastGravity.BOTTOM, // Toast position
        timeInSecForIosWeb: 3 // Duration for iOS/Web
        );
  }

  /// Shows a red flushbar error message at the top of the screen
  static void flushBarErrorMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red.shade700, // Error-style red
      duration: const Duration(seconds: 3), // Auto dismiss after 3s
      margin: const EdgeInsets.all(8), // Outer margin
      borderRadius: BorderRadius.circular(8), // Rounded corners
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP, // Show from top
      animationDuration: const Duration(milliseconds: 500), // Smooth animation
      forwardAnimationCurve: Curves.easeIn, // Animation curve
    ).show(context); // Cascade: show flushbar immediately
  }

  /// Shows a floating snackbar with the given message
  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blueAccent, // Blue background
        behavior: SnackBarBehavior.floating, // Detaches from bottom
        duration: const Duration(seconds: 3), // Duration visible
      ),
    );
  }
}
