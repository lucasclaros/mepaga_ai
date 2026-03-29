import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/cache_jwt_uc.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:meta/meta.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc({
    required this.userLoginUC,
    required this.cacheJwtUC,
  }) : super(LoginBlocInitial()) {
    on<UserLogin>(_mapLoginEventToState);
  }

  final UserLoginUC userLoginUC;
  final CacheJwtUC cacheJwtUC;

  Future<void> _mapLoginEventToState(
    UserLogin event,
    Emitter<LoginBlocState> emit,
  ) async {
    emit(LoginBlocLoading());
    try {
      final jwt = await userLoginUC(
        UserLoginUCParams(
          email: event.email,
          password: event.password,
        ),
      );
      await cacheJwtUC(CacheJwtUCParams(jwt: jwt));
      emit(LoginBlocSuccess());
    } catch (e) {
      if (e is MPGException) {
        if (e is InvalidCredentialsException) {
          emit(LoginBlocInvalidCredentials(message: e.message));
        } else if (e is OTPNotVerifiedException) {
          emit(LoginBlocOTPNotVerified(message: e.message));
        } else {
          emit(LoginBlocError(message: e.message));
        }
      }
    }
  }
}
