import 'package:bloc/bloc.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_user_info_uc.dart';
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
  }) : super(HomeLoading()) {
    on<UserInfo>(_mapUserInfoToState);
  }

  final GetUserInfoUC getUserInfoUC;
  final GetUserTicketsUC getUserTicketsUC;

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
}
