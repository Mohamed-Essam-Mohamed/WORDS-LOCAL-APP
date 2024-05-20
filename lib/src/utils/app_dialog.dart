import 'app_text_style.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(
              message,
              style: AppTextStyle.textStyle20,
            ),
            const Spacer(),
            const Icon(
              Icons.done,
              color: Colors.green,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
