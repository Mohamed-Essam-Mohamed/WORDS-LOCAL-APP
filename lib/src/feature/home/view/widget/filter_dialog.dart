import 'package:app_english/src/controller/read_data/read_data_cubit.dart';
import 'package:app_english/src/controller/read_data/read_data_state.dart';
import 'package:app_english/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: Colors.grey.withAlpha(30),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getLabelText("Language"),
                const SizedBox(height: 10),
                _getLanguageFilter(context),
                const SizedBox(height: 15),
                _getLabelText("Sorted By"),
                const SizedBox(height: 10),
                _getSortedByFilter(context),
                const SizedBox(height: 15),
                _getLabelText("Sorting Type"),
                const SizedBox(
                  height: 10,
                ),
                _getSortingTypeFilter(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getSortedByFilter(BuildContext context) {
    return _getFilterField(
      labels: ["Time", "Word Length"],
      onTaps: [
        () => ReadDataCubit.get(context).updateSortedBy(SortedBy.time),
        () => ReadDataCubit.get(context).updateSortedBy(SortedBy.wordLength),
      ],
      conditionsOfActivation: [
        ReadDataCubit.get(context).sortedBy == SortedBy.time,
        ReadDataCubit.get(context).sortedBy == SortedBy.wordLength,
      ],
    );
  }

  Widget _getSortingTypeFilter(BuildContext context) {
    return _getFilterField(
      labels: ["Ascending", "Descending"],
      onTaps: [
        () =>
            ReadDataCubit.get(context).updateSortingType(SortingType.ascending),
        () => ReadDataCubit.get(context)
            .updateSortingType(SortingType.descending),
      ],
      conditionsOfActivation: [
        ReadDataCubit.get(context).sortingType == SortingType.ascending,
        ReadDataCubit.get(context).sortingType == SortingType.descending,
      ],
    );
  }

  Widget _getLanguageFilter(BuildContext context) {
    return _getFilterField(
      labels: ["Arabic", "English", "All"],
      onTaps: [
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.arabic),
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.english),
        () => ReadDataCubit.get(context)
            .updateLanguageFilter(LanguageFilter.allWords),
      ],
      conditionsOfActivation: [
        ReadDataCubit.get(context).languageFilter == LanguageFilter.arabic,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.english,
        ReadDataCubit.get(context).languageFilter == LanguageFilter.allWords,
      ],
    );
  }

  Widget _getFilterField({
    required List<String> labels,
    required List<VoidCallback> onTaps,
    required List<bool> conditionsOfActivation,
  }) {
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTaps[i],
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.whiteColor),
                color: conditionsOfActivation[i]
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
              ),
              child: Center(
                child: Text(
                  labels[i],
                  style: TextStyle(
                    color: conditionsOfActivation[i]
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _getLabelText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
