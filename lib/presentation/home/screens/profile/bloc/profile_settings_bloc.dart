import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/use_case.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:meta/meta.dart';

part 'profile_settings_event.dart';
part 'profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc({
    required this.userLogoutUC,
  }) : super(ProfileSettingsInitial()) {
    on<ProfileSettingsLogout>(_mapUserLogoutToState);
  }

  final UserLogoutUC userLogoutUC;

  Future<void> _mapUserLogoutToState(
    ProfileSettingsLogout event,
    Emitter<ProfileSettingsState> emit,
  ) async {
    emit(ProfileSettingsLogoutLoading());

    try {
      await userLogoutUC(NoParams());
      UserMM().email = '';
      UserMM().name = '';
      UserMM().pixKey = '';
      emit(ProfileSettingsLogoutSuccess());
    } catch (e) {
      if (e is Exception) {
        emit(ProfileSettingsLogoutError(message: e.toString()));
      }
    }
  }
}
