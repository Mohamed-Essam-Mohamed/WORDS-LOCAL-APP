import 'package:app_english/src/constant/hive_constant.dart';
import 'package:app_english/src/controller/write_data/write_data_state.dart';
import 'package:app_english/src/model/word_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class WriteDataCubit extends Cubit<WriteDataState> {
  static WriteDataCubit get(context) => BlocProvider.of(context);
  WriteDataCubit() : super(WriteDataInitial());
  final Box _box = Hive.box(wordsBox);
  String text = '';
  bool isArabic = true;
  int colorCode = 0XFF4A47A3;
  void updateText(String text) {
    this.text = text;
  }

  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
  }

  void addWord() {
    emit(WriteDataLoading());
    _tryAngCatch(() {
      List<WordModel> words = _getWords();
      words.add(
        WordModel(
          indexAtDatabase: words.length,
          text: text,
          isArabic: isArabic,
          colorCode: colorCode,
        ),
      );
      _box.put(wordsList, words);
    }, "we have problems when we add word , please try again");
  }

  void deleteWord(int indexAtDatabase) {
    _tryAngCatch(() {
      List<WordModel> words = _getWords();
      words.removeAt(indexAtDatabase);
      for (var i = indexAtDatabase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDataBase();
      }
      _box.put(wordsList, words);
    }, "we have problems when we delete word , please try again");
    emit(WriteDataLoading());
  }

  void addSimilarWord(int indexAtDatabase) {
    _tryAngCatch(
      () {
        List<WordModel> words = _getWords();
        words[indexAtDatabase] =
            words[indexAtDatabase].addSimilarWord(text, isArabic);
        _box.put(wordsList, words);
      },
      "we have problems when we add similar word , please try again",
    );
  }

  void addExample(int indexAtDatabase) {
    _tryAngCatch(
      () {
        List<WordModel> words = _getWords();
        words[indexAtDatabase] =
            words[indexAtDatabase].addExample(text, isArabic);
        _box.put(wordsList, words);
      },
      "we have problems when we add example , please try again",
    );
  }

  void deleteSimilarWord(
      int indexAtDatabase, bool isArabicSimilarWord, int indexAtSimilarWord) {
    _tryAngCatch(
      () {
        List<WordModel> words = _getWords();
        words[indexAtDatabase] = words[indexAtDatabase]
            .deleteSimilarWord(indexAtSimilarWord, isArabicSimilarWord);
        _box.put(wordsList, words);
      },
      "we have problems when we delete similar word , please try again",
    );
  }

  void deleteExample(
      int indexAtDatabase, bool isArabicExample, int indexAtExample) {
    _tryAngCatch(
      () {
        List<WordModel> words = _getWords();
        words[indexAtDatabase] = words[indexAtDatabase]
            .deleteExaple(indexAtExample, isArabicExample);
        _box.put(wordsList, words);
      },
      "we have problems when we delete example , please try again",
    );
  }

  void _tryAngCatch(VoidCallback function, String messageError) {
    emit(WriteDataLoading());
    try {
      function.call();
      emit(WriteDataSuccess());
    } catch (e) {
      emit(
        WriteDataError(messageError: messageError),
      );
    }
  }

  List<WordModel> _getWords() =>
      List.from(_box.get(wordsList, defaultValue: [])).cast<WordModel>();
}
