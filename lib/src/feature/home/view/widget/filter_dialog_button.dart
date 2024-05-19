import 'package:app_english/src/feature/home/view/widget/filter_dialog.dart';
import 'package:app_english/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context, builder: ((context) => const FilterDialog()));
      },
      child: const CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.whiteColor,
        child: Icon(
          Icons.filter_list,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
