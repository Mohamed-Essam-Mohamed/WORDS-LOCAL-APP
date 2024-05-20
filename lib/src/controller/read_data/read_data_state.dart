import '../../model/word_model.dart';

abstract class ReadDataState {}

class ReadDataInitial extends ReadDataState {}

class ReadDataLoading extends ReadDataState {}

class ReadDataError extends ReadDataState {
  final String messageError;

  ReadDataError({required this.messageError});
}

class ReadDataSuccess extends ReadDataState {
  final List<WordModel> words;
  ReadDataSuccess({required this.words});
}
