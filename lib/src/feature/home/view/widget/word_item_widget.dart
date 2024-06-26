import '../../../../controller/read_data/read_data_cubit.dart';
import '../../../../controller/write_data/write_data_cubit.dart';
import '../../../details/view/details_screen.dart';
import '../../../../model/word_model.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter/material.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});
  final WordModel wordModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        WriteDataCubit.get(context).deleteWord(wordModel.indexAtDatabase);
        ReadDataCubit.get(context).getAllWords();
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailsScreen(wordModel: wordModel)),
          ),
        ).then(
          (value) async {
            Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                ReadDataCubit.get(context).getAllWords();
              },
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: _getBoxDecoration(),
        child: Center(
          child: Text(
            wordModel.text,
            style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(wordModel.colorCode),
      );
}
