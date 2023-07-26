import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/user_login_uc.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:meta/meta.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  LoginBloc({required this.userLoginUC}) : super(LoginBlocInitial()) {
    on<UserLogin>(_mapLoginEventToState);
  }

  final UserLoginUC userLoginUC;

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
      emit(LoginBlocSuccess());
      UserMM().name = userAuth.name;
    } catch (e) {
      if (e is MPGException) {
        emit(LoginBlocError(message: e.message));
      }
    }
  }
}
