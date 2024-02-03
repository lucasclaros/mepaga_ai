part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccessEmpty extends HomeState {}

class HomeSuccess extends HomeState {
  HomeSuccess({required this.tickets});

  final List<Ticket> tickets;
}

class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}
