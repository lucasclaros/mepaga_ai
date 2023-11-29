part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}

class LogoutLoading extends HomeState {}

class LogoutSuccess extends HomeState {}

class LogoutError extends HomeState {
  LogoutError({required this.message});

  final String message;
}
