abstract class WriteDataState {}

class WriteDataInitial extends WriteDataState {}

class WriteDataLoading extends WriteDataState {}

class WriteDataSuccess extends WriteDataState {}

class WriteDataError extends WriteDataState {
  final String messageError;

  WriteDataError({required this.messageError});
}
