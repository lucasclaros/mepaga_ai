import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:meta/meta.dart';

part 'add_email_platform_event.dart';
part 'add_email_platform_state.dart';

class AddEmailPlatformBloc
    extends Bloc<AddEmailPlatformEvent, AddEmailPlatformState> {
  AddEmailPlatformBloc({required this.platformRegisterUC})
      : super(AddEmailPlatformInitial()) {
    on<SendEmailPlatformOtp>(_mapSendEmailPlatformOtpToState);
  }

  final PlatformRegisterUC platformRegisterUC;

  Future<void> _mapSendEmailPlatformOtpToState(
    SendEmailPlatformOtp event,
    Emitter<AddEmailPlatformState> emit,
  ) async {
    emit(SendEmailPlatformOtpLoading());

    try {
      await platformRegisterUC(
        PlatformRegisterUCParams(
          platform: event.platform,
          email: event.email,
        ),
      );
      emit(SendEmailPlatformOtpSuccess());
    } catch (e) {
      if (e is MPGException) {
        emit(SendEmailPlatformOtpError(message: e.message));
      }
    }
  }
}
