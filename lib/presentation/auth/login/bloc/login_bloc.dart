import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/set_cache_value_uc.dart';
import 'package:domain/use_cases/use_case.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:meta/meta.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc({
    required this.userLoginUC,
    required this.userLogoutUC,
    required this.setCacheValueUC,
  }) : super(LoginBlocInitial()) {
    on<UserLogin>(_mapLoginEventToState);
    on<UserLogout>(_mapLogoutEventToState);
  }

  final UserLoginUC userLoginUC;
  final UserLogoutUC userLogoutUC;
  final SetCacheValueUC setCacheValueUC;

  Future<void> _mapLoginEventToState(
    UserLogin event,
    Emitter<LoginBlocState> emit,
  ) async {
    emit(LoginBlocLoading());
    try {
      final userAuth = await userLoginUC(
        UserLoginUCParams(
          email: event.email,
          password: event.password,
        ),
      );
      await setCacheValueUC(
        SetCacheValueUCParams(
          key: 'jwt',
          value: userAuth,
        ),
      );
      emit(LoginBlocSuccess());
    } catch (e) {
      if (e is MPGException) {
        emit(LoginBlocError(message: e.message));
      }
    }
  }

  Future<void> _mapLogoutEventToState(
    UserLogout event,
    Emitter<LoginBlocState> emit,
  ) async {
    emit(LoginBlocLoading());
    try {
      await userLogoutUC(NoParams());
      emit(LoginBlocLogout());
    } catch (e) {
      if (e is MPGException) {
        emit(LoginBlocError(message: e.message));
      }
    }
  }
}
