part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class UserRegister extends RegisterEvent {
  UserRegister({
    required this.email,
    required this.password,
    required this.name,
  });

  final String email;
  final String password;
  final String name;
}
