import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/models/platform.dart';
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
  }) : super(PlatformRegistrationInitial()) {
    on<ListUserPlatforms>(_mapListUserPlatformsInfoToState);
    on<RegisterPlatform>(_mapRegisterPlatformToState);
  }

  final GetUserPlatformsUC getUserPlatformsUC;
  final PlatformRegisterUC platformRegisterUC;

  Future<void> _mapListUserPlatformsInfoToState(
    PlatformRegistrationEvent event,
    Emitter<PlatformRegistrationState> emit,
  ) async {
    emit(ListPlatformsLoading());

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
    try {
      await platformRegisterUC(
        PlatformRegisterUCParams(
          platform: event.platform,
          email: event.email,
        ),
      );
      emit(RegisterPlatformSuccess());
    } catch (e) {
      if (e is MPGException) {
        emit(RegisterPlatformError(message: e.message));
      }
    }
  }
}
