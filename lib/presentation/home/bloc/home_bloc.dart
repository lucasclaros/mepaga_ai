import 'package:bloc/bloc.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/use_case.dart';
import 'package:domain/use_cases/user_logout_uc.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getUserInfoUC,
    required this.userLogoutUC,
  }) : super(HomeInitial()) {
    on<UserInfo>(_mapUserInfoToState);
    on<UserLogout>(_mapUserLogoutToState);
  }

  final GetUserInfoUC getUserInfoUC;
  final UserLogoutUC userLogoutUC;

  Future<void> _mapUserInfoToState(
    UserInfo event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final user = await getUserInfoUC(NoParams());
      UserMM().email = user.email;
      UserMM().name = user.name;
      UserMM().pixKey = user.pixKey;
      emit(HomeSuccess());
    } catch (e) {
      if (e is Exception) {
        emit(HomeError(message: e.toString()));
      }
    }
  }

  Future<void> _mapUserLogoutToState(
    UserLogout event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      await userLogoutUC(NoParams());
      UserMM().email = '';
      UserMM().name = '';
      UserMM().pixKey = '';
      emit(HomeSuccess());
    } catch (e) {
      if (e is Exception) {
        emit(HomeError(message: e.toString()));
      }
    }
  }
}
