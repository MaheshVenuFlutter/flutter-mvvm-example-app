import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
}
