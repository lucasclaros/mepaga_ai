part of 'button_status_bloc.dart';

@immutable
abstract class ButtonStatusEvent {}

class ButtonStateRequest extends ButtonStatusEvent {
  ButtonStateRequest({required this.email});

  final String email;
}
