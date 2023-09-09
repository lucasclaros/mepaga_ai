part of 'login_bloc.dart';

@immutable
abstract class LoginBlocEvent {}

class UserLogin extends LoginBlocEvent {
  UserLogin({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
