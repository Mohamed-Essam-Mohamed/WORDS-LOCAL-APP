// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_english/src/controller/read_data/read_data_cubit.dart';
import 'package:app_english/src/controller/read_data/read_data_state.dart';
import 'package:app_english/src/feature/home/view/widget/exeption_widget.dart';
import 'package:app_english/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:app_english/src/controller/write_data/write_data_cubit.dart';
import 'package:app_english/src/feature/details/view/widget/updaste_word_dialog.dart';
import 'package:app_english/src/feature/details/view/widget/word_info_widget.dart';
import 'package:app_english/src/model/word_model.dart';
import 'package:app_english/src/utils/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/update_word_buttom_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.wordModel,
  }) : super(key: key);
  final WordModel wordModel;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late WordModel _wordModel;

  @override
  void initState() {
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataState>(
        builder: (context, state) {
          if (state is ReadDataSuccess) {
            int index = state.words.indexWhere((element) =>
                element.indexAtDatabase == _wordModel.indexAtDatabase);
            _wordModel = state.words[index];
            return _getSuccessBody(context);
          }
          if (state is ReadDataError) {
            return ExceptionWidget(
                iconData: Icons.error, message: state.messageError);
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.whiteColor,
            ),
          );
        },
      ),
    );
  }

  ListView _getSuccessBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        _getLabelText("Word"),
        const SizedBox(
          height: 5,
        ),
        WordInfoWidget(
          color: Color(_wordModel.colorCode),
          text: _wordModel.text,
          isArabic: _wordModel.isArabic,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _getLabelText("Similar Words"),
            const Spacer(),
            UpdateWordButton(
              color: Color(_wordModel.colorCode),
              onTap: () => showDialog(
                  context: context,
                  builder: ((context) => UpdateWordDialog(
                        isExample: false,
                        colorCode: _wordModel.colorCode,
                        indexAtDatabase: _wordModel.indexAtDatabase,
                      ))),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < _wordModel.arabicSimilarWords.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: true,
            text: _wordModel.arabicSimilarWords[i],
            onPressed: () => _deleteArabicSimilarWord(i),
          ),
        for (int i = 0; i < _wordModel.englishSimilarWords.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: false,
            text: _wordModel.englishSimilarWords[i],
            onPressed: () => _deleteEnglishSimilarWord(i),
          ),
        const SizedBox(height: 20),
        Row(
          children: [
            _getLabelText("Examples"),
            const Spacer(),
            UpdateWordButton(
              color: Color(_wordModel.colorCode),
              onTap: () => showDialog(
                  context: context,
                  builder: ((context) => UpdateWordDialog(
                        isExample: true,
                        colorCode: _wordModel.colorCode,
                        indexAtDatabase: _wordModel.indexAtDatabase,
                      ))),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < _wordModel.arabicExamples.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: true,
            text: _wordModel.arabicExamples[i],
            onPressed: () => _deleteArabicExample(i),
          ),
        for (int i = 0; i < _wordModel.englishExamples.length; i++)
          WordInfoWidget(
            color: Color(_wordModel.colorCode),
            isArabic: false,
            text: _wordModel.englishExamples[i],
            onPressed: () => _deleteEnglishExample(i),
          ),
      ],
    );
  }

  void _deleteEnglishExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexAtDatabase,
      false,
      index,
    );
    ReadDataCubit.get(context).getAllWords();
  }

  void _deleteArabicExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _wordModel.indexAtDatabase,
      true,
      index,
    );
    ReadDataCubit.get(context).getAllWords();
  }

  void _deleteEnglishSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexAtDatabase,
      false,
      index,
    );
    ReadDataCubit.get(context).getAllWords();
  }

  void _deleteArabicSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _wordModel.indexAtDatabase,
      true,
      index,
    );
    ReadDataCubit.get(context).getAllWords();
  }

  Widget _getLabelText(String label) => Text(
        label,
        style: TextStyle(
          color: Color(widget.wordModel.colorCode),
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      );

  AppBar _getAppBar(context) => AppBar(
        foregroundColor: Color(widget.wordModel.colorCode),
        centerTitle: true,
        title: const Text(
          "Word Details",
          style: AppTextStyle.textStyle26,
        ),
        actions: [
          IconButton(
            onPressed: () => _deleteWord(context),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 30,
            ),
          )
        ],
      );

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(widget.wordModel.indexAtDatabase);
    Navigator.pop(context);
  }
}
