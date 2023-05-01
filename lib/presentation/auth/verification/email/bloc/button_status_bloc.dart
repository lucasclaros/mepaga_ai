import 'package:domain/use_cases/email_validation_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'button_status_event.dart';
part 'button_status_state.dart';

class ButtonStatusBloc extends Bloc<ButtonStatusEvent, ButtonStatusState> {
  ButtonStatusBloc({
    required this.emailValidationUC,
  }) : super(InactiveButton()) {
    on<ButtonStateRequest>(_mapButtonStateRequest);
  }

  final EmailValidationUC emailValidationUC;

  Future<void> _mapButtonStateRequest(
    ButtonStateRequest event,
    Emitter<ButtonStatusState> emit,
  ) async {
    try {
      final result = await emailValidationUC(
        EmailVerifciationUCParams(text: event.email),
      );

      if (result) {
        emit.call(ActiveButton());
      } else {
        emit.call(InactiveButton());
      }
    } catch (_) {
      emit.call(InactiveButton());
    }
  }
}
