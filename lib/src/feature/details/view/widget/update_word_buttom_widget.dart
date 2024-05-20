import '../../../../utils/app_colors.dart';
import 'package:flutter/material.dart';

class UpdateWordButton extends StatelessWidget {
  const UpdateWordButton({super.key, required this.color, required this.onTap});
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 35,
        decoration: _getBoxDecoration(),
        child: const Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      );
}
