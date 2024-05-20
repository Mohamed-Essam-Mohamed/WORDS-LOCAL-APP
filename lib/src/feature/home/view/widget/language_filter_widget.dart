import '../../../../controller/read_data/read_data_cubit.dart';
import '../../../../controller/read_data/read_data_state.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Text(
          _mapLanguageFilterEnumToString(
              ReadDataCubit.get(context).languageFilter),
          style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 21,
              fontWeight: FontWeight.bold),
        );
      },
    );
  }

  String _mapLanguageFilterEnumToString(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.allWords) {
      return "All Words";
    } else if (languageFilter == LanguageFilter.english) {
      return "English Only";
    } else {
      return "Arabic Only";
    }
  }
}
