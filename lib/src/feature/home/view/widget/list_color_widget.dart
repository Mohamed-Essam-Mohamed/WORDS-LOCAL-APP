import '../../../../controller/write_data/write_data_cubit.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter/material.dart';

class ListColorWidget extends StatelessWidget {
  const ListColorWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> _colorCodes = const [
    0XFF4A47A3,
    0XFF0C7B93,
    0xFF892CDC,
    0XFFBC6FF1,
    0xFFF4ABC4,
    0XFFC70039,
    0xFF8FBC8F,
    0xFFFA8072,
    0XFF4D4C7D,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _colorCodes.length,
        itemBuilder: (context, index) => _getItemDesign(index, context),
        separatorBuilder: (context, index) => const SizedBox(width: 7),
      ),
    );
  }

  Widget _getItemDesign(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        WriteDataCubit.get(context).updateColorCode(_colorCodes[index]);
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: activeColorCode == _colorCodes[index]
              ? Border.all(color: AppColors.whiteColor, width: 2)
              : null,
          color: Color(_colorCodes[index]),
        ),
        child: activeColorCode == _colorCodes[index]
            ? const Center(
                child: Icon(
                  Icons.done,
                  color: AppColors.whiteColor,
                ),
              )
            : null,
      ),
    );
  }
}
