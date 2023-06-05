part of 'button_status_bloc.dart';

@immutable
abstract class ButtonStatusState {}

class InactiveButton extends ButtonStatusState {}

class ActiveButton extends ButtonStatusState {}
