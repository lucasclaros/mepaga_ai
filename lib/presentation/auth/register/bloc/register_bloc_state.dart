part of 'register_bloc.dart';

@immutable
abstract class RegisterBlocState {}

class RegisterBlocInitial extends RegisterBlocState {}

class RegisterBlocLoading extends RegisterBlocState {}

class RegisterBlocSuccess extends RegisterBlocState {}

class RegisterBlocError extends RegisterBlocState {
  RegisterBlocError({this.message = 'Unexpected error occurred.'});

  final String message;
}

class RegisterBlocInvalidEmail extends RegisterBlocError {
  RegisterBlocInvalidEmail({super.message});
}

class RegisterBlocUserAlreadyExists extends RegisterBlocError {
  RegisterBlocUserAlreadyExists({super.message});
}
