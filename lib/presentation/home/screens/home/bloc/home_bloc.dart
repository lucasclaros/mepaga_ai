import 'package:bloc/bloc.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:domain/use_cases/use_case.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.getUserInfoUC,
    required this.getUserTicketsUC,
    required this.getUserPlatformsUC,
  }) : super(HomeLoading()) {
    on<UserInfo>(_mapUserInfoToState);
    on<UserPlatforms>(_mapUserPlatformsInfoToState);

    add(UserInfo(initialLoading: true));
    add(UserPlatforms());
  }

  final GetUserInfoUC getUserInfoUC;
  final GetUserTicketsUC getUserTicketsUC;
  final GetUserPlatformsUC getUserPlatformsUC;

  Future<void> _mapUserInfoToState(
    UserInfo event,
    Emitter<HomeState> emit,
  ) async {
    if (event.initialLoading) {
      emit(HomeLoading());
    }

    try {
      final user = await getUserInfoUC(NoParams());
      UserMM().email = user.email;
      UserMM().name = user.name;
      UserMM().pixKey = user.pixKey;
      final tickets = await getUserTicketsUC(NoParams());
      emit(HomeSuccess(tickets: tickets));
    } catch (e) {
      if (e is Exception) {
        emit(HomeError(message: e.toString()));
      }
    }
  }

  Future<void> _mapUserPlatformsInfoToState(
    UserPlatforms event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final platforms = await getUserPlatformsUC(NoParams());
      if (platforms.length == 1 && !platforms[0].associated) {
        emit(RegisterPlatform());
      }
    } catch (_) {}
  }
}
