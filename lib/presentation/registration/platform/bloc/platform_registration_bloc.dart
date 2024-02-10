import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/models/platform.dart';
import 'package:domain/use_cases/check_platform_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/platform_register_uc.dart';
import 'package:domain/use_cases/use_case.dart';
import 'package:meta/meta.dart';

part 'platform_registration_event.dart';
part 'platform_registration_state.dart';

class PlatformRegistrationBloc
    extends Bloc<PlatformRegistrationEvent, PlatformRegistrationState> {
  PlatformRegistrationBloc({
    required this.getUserPlatformsUC,
    required this.platformRegisterUC,
    required this.checkPlatformUC,
  }) : super(PlatformRegistrationInitial()) {
    on<ListUserPlatforms>(_mapListUserPlatformsInfoToState);
    on<RegisterPlatform>(_mapRegisterPlatformToState);
    on<CheckUserPlatform>(_mapCheckUserPlatformToState);
    on<SendEmailPlatformOtp>(_mapSendEmailPlatformOtpToState);
    add(ListUserPlatforms());
    add(
      CheckUserPlatform(
        platform: 'byma',
      ),
    );
  }

  final GetUserPlatformsUC getUserPlatformsUC;
  final PlatformRegisterUC platformRegisterUC;
  final CheckPlatformUC checkPlatformUC;

  Future<void> _mapListUserPlatformsInfoToState(
    ListUserPlatforms event,
    Emitter<PlatformRegistrationState> emit,
  ) async {
    if (event.initialLoading) {
      emit(ListPlatformsLoading());
    }

    try {
      final platforms = await getUserPlatformsUC(NoParams());
      emit(ListPlatformsSuccess(platforms: platforms));
    } catch (e) {
      if (e is MPGException) {
        emit(ListPlatformsError(message: e.message));
      }
    }
  }

  Future<void> _mapRegisterPlatformToState(
    RegisterPlatform event,
    Emitter<PlatformRegistrationState> emit,
  ) async {
    emit(RegisterPlatformLoading());

    try {
      await platformRegisterUC(
        PlatformRegisterUCParams(
          platform: event.platform,
          email: event.email,
        ),
      );
      emit(RegisterPlatformSuccess(platform: event.platform));
    } catch (e) {
      if (e is MPGException) {
        emit(RegisterPlatformError(message: e.message));
      }
    } finally {
      add(ListUserPlatforms(initialLoading: false));
    }
  }

  Future<void> _mapCheckUserPlatformToState(
    CheckUserPlatform event,
    Emitter<PlatformRegistrationState> emit,
  ) async {
    emit(CheckUserPlatformLoading());

    try {
      await checkPlatformUC(CheckPlatformUCParams(platform: event.platform));
    } catch (e) {
      if (e is MPGException) {
        if (e is FoundAccountNoAssociation) {
          emit(CheckUserPlatformSuccessNoAssociation());
        }

        if (e is NoAccountFound) {
          emit(CheckUserPlatformSuccessNoAccount());
        }
      }
    }
  }

  Future<void> _mapSendEmailPlatformOtpToState(
    SendEmailPlatformOtp event,
    Emitter<PlatformRegistrationState> emit,
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
