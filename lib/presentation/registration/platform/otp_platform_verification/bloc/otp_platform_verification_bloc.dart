import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/otp_verification_uc.dart';
import 'package:meta/meta.dart';

part 'otp_platform_verification_event.dart';
part 'otp_platform_verification_state.dart';

class OtpPlatformVerificationBloc
    extends Bloc<OtpPlatformVerificationEvent, OtpPlatformVerificationState> {
  OtpPlatformVerificationBloc({
    required this.otpVerificationUC,
    required this.cacheJwtUC,
  }) : super(OtpPlatformVerificationInitial()) {
    on<OtpPlatformVerificationSend>(_mapOtpVerificationSendToState);
  }

  final OTPVerificationUC otpVerificationUC;
  final CacheJwtUC cacheJwtUC;

  Future<void> _mapOtpVerificationSendToState(
    OtpPlatformVerificationSend event,
    Emitter<OtpPlatformVerificationState> emit,
  ) async {
    emit(OtpPlatformVerificationLoading());

    try {
      await otpVerificationUC(
        OTPVerificationUCParams(
          param: 'platform',
          data: event.platform,
          code: event.code,
        ),
      );
      emit(OtpPlatformVerificationSuccess());
    } catch (e) {
      if (e is MPGException) {
        if (e is OTPWrongCode) {
          emit(OtpPlatformVerificationOTPInvalid(message: e.message));
        } else if (e is OTPExpired) {
          emit(OtpPlatformVerificationOTPExpired(message: e.message));
        } else {
          emit(OtpPlatformVerificationError(message: e.message));
        }
      }
    }
  }
}
