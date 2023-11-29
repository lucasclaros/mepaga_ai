part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class UserInfo extends HomeEvent {}

class UserLogout extends HomeEvent {}
