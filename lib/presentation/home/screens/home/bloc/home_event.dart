part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class UserInfo extends HomeEvent {
  UserInfo({this.initialLoading = false});

  final bool initialLoading;
}

class UserPlatforms extends HomeEvent {}

