import 'package:app_english/src/controller/read_data/read_data_cubit.dart';
import 'package:app_english/src/controller/read_data/read_data_state.dart';
import 'package:app_english/src/feature/home/view/widget/exeption_widget.dart';
import 'package:app_english/src/feature/home/view/widget/word_item_widget.dart';
import 'package:app_english/src/model/word_model.dart';
import 'package:app_english/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if (state is ReadDataSuccess) {
          if (state.words.isEmpty) {
            return _getEmptyWordsWidget();
          }
          return _getWordsWidget(state.words);
        } else if (state is ReadDataError) {
          return _getFailedWidget(state.messageError);
        } else {
          return _getLoadingWidget();
        }
      },
    );
  }

  Widget _getWordsWidget(List<WordModel> words) {
    return GridView.builder(
      itemCount: words.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2 / 1.5,
      ),
      itemBuilder: ((context, index) {
        return WordItemWidget(wordModel: words[index]);
      }),
    );
  }

  Widget _getEmptyWordsWidget() {
    return const ExceptionWidget(
      iconData: Icons.list_rounded,
      message: "Empty Words List",
    );
  }

  Widget _getFailedWidget(String message) {
    return ExceptionWidget(
      iconData: Icons.list_rounded,
      message: message,
    );
  }

  Widget _getLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.whiteColor,
      ),
    );
  }
}
