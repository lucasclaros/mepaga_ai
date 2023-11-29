part of 'register_bloc.dart';

@immutable
abstract class RegisterBlocState {}

class RegisterBlocInitial extends RegisterBlocState {}

class RegisterBlocLoading extends RegisterBlocState {}

class RegisterBlocSuccess extends RegisterBlocState {}

class RegisterBlocError extends RegisterBlocState {
  RegisterBlocError({required this.message});

  final String message;
}
