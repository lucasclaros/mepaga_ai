import 'package:bloc/bloc.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
import 'package:domain/use_cases/get_user_platforms_uc.dart';
import 'package:domain/use_cases/get_user_tickets.dart';
import 'package:domain/use_cases/use_case.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mepaga_ai/data/models/user_mm.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, PagingState<int, Ticket>> {
  HomeBloc({
    required this.getUserInfoUC,
    required this.getUserTicketsUC,
    required this.getUserPlatformsUC,
  }) : super(PagingState()) {
    on<UserInfo>(_mapUserInfoToState);
    on<UserPlatforms>(_mapUserPlatformsInfoToState);
  }

  final GetUserInfoUC getUserInfoUC;
  final GetUserTicketsUC getUserTicketsUC;
  final GetUserPlatformsUC getUserPlatformsUC;

  Future<void> _mapUserInfoToState(
    UserInfo event,
    Emitter<PagingState<int, Ticket>> emit,
  ) async {
    if (event.initialLoading || state.isLoading) {
      emit(state.copyWith(isLoading: true, error: null));
    }

    try {
      final user = await getUserInfoUC(NoParams());
      UserMM().email = user.email;
      UserMM().name = user.name;
      UserMM().pixKey = user.pixKey;
      final newKey = (state.keys?.last ?? 0) + 1;
      final tickets = await getUserTicketsUC(NoParams());
      emit(
        state.copyWith(
          pages: [...?state.pages, tickets],
          keys: [...?state.keys, newKey],
          hasNextPage: false,
          isLoading: false,
        ),
      );
    } catch (e) {
      if (e is Exception) {
        emit(state.copyWith(error: e, isLoading: false));
      }
    }
  }

  Future<void> _mapUserPlatformsInfoToState(
    UserPlatforms event,
    Emitter<PagingState<int, Ticket>> emit,
  ) async {
    try {
      final platforms = await getUserPlatformsUC(NoParams());
      if (platforms.length == 1 && !platforms[0].associated) {
        emit(PagingState());
      }
    } catch (_) {}
  }
}
