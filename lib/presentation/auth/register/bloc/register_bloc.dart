import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/user_register_uc.dart';
import 'package:meta/meta.dart';

part 'register_bloc_event.dart';
part 'register_bloc_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterBlocState> {
  RegisterBloc({required this.userRegisterUC}) : super(RegisterBlocInitial()) {
    on<UserRegister>(_mapRegisterEventToState);
  }

  final UserRegisterUC userRegisterUC;

  Future<void> _mapRegisterEventToState(
    UserRegister event,
    Emitter<RegisterBlocState> emit,
  ) async {
    emit(RegisterBlocLoading());

    try {
      await userRegisterUC(
        UserRegisterUCParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );
      emit(RegisterBlocSuccess());
    } catch (e) {
      if (e is MPGException) {
        if (e is UserAlreadyExistsException) {
          emit(RegisterBlocUserAlreadyExists());
        } else if (e is InvalidEmailException) {
          emit(RegisterBlocInvalidEmail());
        } else {
          emit(RegisterBlocError(message: e.message));
        }
      }
    }
  }
}
