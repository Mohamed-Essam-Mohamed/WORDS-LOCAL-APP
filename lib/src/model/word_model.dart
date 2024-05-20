class WordModel {
  final int indexAtDatabase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  const WordModel({
    required this.indexAtDatabase,
    required this.text,
    required this.isArabic,
    required this.colorCode,
    this.arabicSimilarWords = const [],
    this.englishSimilarWords = const [],
    this.arabicExamples = const [],
    this.englishExamples = const [],
  });
  WordModel decrementIndexAtDataBase() {
    return WordModel(
      indexAtDatabase: indexAtDatabase - 1,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: arabicExamples,
      arabicSimilarWords: arabicExamples,
      englishExamples: arabicExamples,
      englishSimilarWords: arabicExamples,
    );
  }

  WordModel addSimilarWord(String word, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initializeSimilarWords(isArabicSimilarWord);
    newSimilarWords.add(word);
    return _getWordAfterCheckSimilarWords(isArabicSimilarWord, newSimilarWords);
  }

  WordModel deleteSimilarWord(
      int indexAtSimilarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initializeSimilarWords(isArabicSimilarWord);
    newSimilarWords.removeAt(indexAtSimilarWord);
    return _getWordAfterCheckSimilarWords(isArabicSimilarWord, newSimilarWords);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExample = _initializeExample(isArabicExample);
    newExample.add(example);
    return _getAfterCheckExample(isArabicExample, newExample);
  }

  WordModel deleteExample(int indexAtExample, bool isArabicExample) {
    List<String> newExample = _initializeExample(isArabicExample);
    newExample.removeAt(indexAtExample);
    return _getAfterCheckExample(isArabicExample, newExample);
  }

  WordModel _getAfterCheckExample(
      bool isArabicExample, List<String> newExample) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicExamples: isArabicExample ? newExample : arabicExamples,
      englishExamples: !isArabicExample ? newExample : englishExamples,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
    );
  }

  List<String> _initializeExample(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicExamples);
    }
    return List.from(englishExamples);
  }

  List<String> _initializeSimilarWords(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }

  WordModel _getWordAfterCheckSimilarWords(
      bool isArabicSimilarWord, List<String> newSimilarWords) {
    return WordModel(
      indexAtDatabase: indexAtDatabase,
      text: text,
      isArabic: isArabic,
      colorCode: colorCode,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
      arabicExamples: arabicExamples,
      englishExamples: englishExamples,
    );
  }
}
