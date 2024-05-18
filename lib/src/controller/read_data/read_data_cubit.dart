import 'dart:math';

import 'package:app_english/src/constant/hive_constant.dart';
import 'package:app_english/src/controller/read_data/read_data_state.dart';
import 'package:app_english/src/model/word_model.dart';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitial());
  final Box _box = Hive.box(wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.ascending;
  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
  }

  void getAllWords() async {
    emit(ReadDataLoading());
    try {
      List<WordModel> words =
          List.from(_box.get(wordsList, defaultValue: [])).cast<WordModel>();
      _removeUnwantedWords(words);
      _applySorting(words);
      emit(ReadDataSuccess(words: words));
    } catch (error) {
      emit(ReadDataError(
          messageError: "Error reading data from database, please try again"));
    }
  }

  void _applySorting(List<WordModel> words) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(words);
      }
    } else {
      words.sort(
          (WordModel a, WordModel b) => a.text.length.compareTo(b.text.length));
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(words);
      }
    }
  }

  void _reverse(List<WordModel> words) {
    for (var i = 0; i < words.length / 2; i++) {
      WordModel temp = words[i];
      words[i] = words[words.length - 1 - i];
      words[words.length - 1 - i] = temp;
    }
  }

  void _removeUnwantedWords(List<WordModel> words) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (var i = 0; i < words.length; i++) {
      if ((LanguageFilter == LanguageFilter.arabic &&
              words[i].isArabic == false) ||
          (LanguageFilter == LanguageFilter.english &&
              words[i].isArabic == true)) {
        words.removeAt(i);
        i--;
      }
    }
  }
}

enum LanguageFilter {
  arabic,
  english,
  allWords,
}

enum SortedBy {
  time,
  wordLength,
}

enum SortingType {
  ascending,
  descending,
}
