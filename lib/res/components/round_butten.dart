import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: loading ? null : onPressed,
        child: loading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
