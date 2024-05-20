import '../../../../controller/write_data/write_data_cubit.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter/material.dart';

class ArOrEnWidget extends StatelessWidget {
  const ArOrEnWidget(
      {super.key, required this.arabicIsSelected, required this.colorCode});
  final int colorCode;
  final bool arabicIsSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainerDesign(true, context),
        const SizedBox(
          width: 5,
        ),
        _getContainerDesign(false, context),
      ],
    );
  }

  InkWell _getContainerDesign(bool buildIsArabic, BuildContext context) {
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context).updateIsArabic(buildIsArabic);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: AppColors.whiteColor),
          color: buildIsArabic == arabicIsSelected
              ? AppColors.whiteColor
              : Color(colorCode),
        ),
        child: Center(
          child: Text(
            buildIsArabic ? "ar" : "en",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !(buildIsArabic == arabicIsSelected)
                  ? AppColors.whiteColor
                  : Color(colorCode),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
