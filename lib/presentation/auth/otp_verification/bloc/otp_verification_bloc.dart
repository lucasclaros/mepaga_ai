import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/otp_verification_uc.dart';
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc({
    required this.otpVerificationUC,
    required this.cacheJwtUC,
  }) : super(OtpVerificationInitial()) {
    on<OtpVerificationSend>(_mapOtpVerificationSendToState);
  }

  final OTPVerificationUC otpVerificationUC;
  final CacheJwtUC cacheJwtUC;

  Future<void> _mapOtpVerificationSendToState(
    OtpVerificationSend event,
    Emitter<OtpVerificationState> emit,
  ) async {
    emit(OtpVerificationLoading());

    try {
      final jwt = await otpVerificationUC(
        OTPVerificationUCParams(
          param: 'email',
          data: event.email,
          code: event.code,
        ),
      );
      await cacheJwtUC(CacheJwtUCParams(jwt: jwt!));
      emit(OtpVerificationSuccess());
    } catch (e) {
      if (e is MPGException) {
        if (e is OTPWrongCode) {
          emit(OtpVerificationInvalidOtp(message: e.message));
        } else if (e is OTPExpired) {
          emit(OtpVerificationOTPExpired(message: e.message));
        } else {
          emit(OtpVerificationError(message: e.message));
        }
      }
    }
  }
}
