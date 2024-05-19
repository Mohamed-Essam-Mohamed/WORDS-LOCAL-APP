import 'package:app_english/src/utils/app_colors.dart';
import 'package:flutter/widgets.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key, required this.iconData, required this.message});
  final IconData iconData;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: AppColors.whiteColor,
          size: 60,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 24),
        )
      ],
    );
  }
}
