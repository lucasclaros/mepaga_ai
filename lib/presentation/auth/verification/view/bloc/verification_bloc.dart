import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/email_verification_uc.dart';
import 'package:mepaga_ai/data/mappers/domain_to_view.dart';
import 'package:mepaga_ai/data/models/user_vm.dart';
import 'package:meta/meta.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc({
    required this.emailValidationUC,
  }) : super(InitialState()) {
    on<EmailVerificationRequest>(_mapEmailVerificationRequest);
  }

  final EmailVerificationUC emailValidationUC;

  Future<void> _mapEmailVerificationRequest(
    EmailVerificationRequest event,
    Emitter<VerificationState> emit,
  ) async {
    emit.call(Loading());
    try {
      final user = await emailValidationUC(
        EmailVerificationUCParams(userEmail: event.userEmail),
      );
      emit.call(
        ValidEmail(
          user: user.toVM(),
        ),
      );
    } catch (error) {
      if (error is UnexpectedException) {
        emit.call(UnexpectedError());
      } else {
        emit.call(InvalidEmail());
      }
    }
  }
}
