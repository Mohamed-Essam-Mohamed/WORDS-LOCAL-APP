import '../../../../utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.colorCode, required this.onTap});
  final int colorCode;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(
                  color: Color(colorCode), fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
