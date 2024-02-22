import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/models/ticket.dart';
import 'package:domain/use_cases/get_ticket_info.dart';
import 'package:domain/use_cases/ticket_price_register_uc.dart';
import 'package:meta/meta.dart';

part 'ticket_configuration_event.dart';
part 'ticket_configuration_state.dart';

class TicketConfigurationBloc
    extends Bloc<TicketConfigurationEvent, TicketConfigurationState> {
  TicketConfigurationBloc({
    required this.getTicketInfoUC,
    required this.ticketPriceRegisterUC,
    this.ticketId,
  }) : super(TicketConfigurationInitial()) {
    on<GetTicketInfo>(_mapGetTicketInfoToState);
    on<RegisterTicketInfo>(_mapRegisterTicketInfoToState);

    if (ticketId != null) {
      add(GetTicketInfo(ticketId: ticketId!));
    }
  }

  final GetTicketInfoUC getTicketInfoUC;
  final TicketPriceRegisterUC ticketPriceRegisterUC;
  final String? ticketId;

  Future<void> _mapGetTicketInfoToState(
    GetTicketInfo event,
    Emitter<TicketConfigurationState> emit,
  ) async {
    emit(GetTicketInfoLoading());
    try {
      final ticket = await getTicketInfoUC.call(
        GetTicketInfoUCParams(
          ticketId: event.ticketId,
        ),
      );
      emit(GetTicketInfoSuccess(ticket: ticket));
    } catch (e) {
      emit(GetTicketInfoError(e.toString()));
    }
  }

  Future<void> _mapRegisterTicketInfoToState(
    RegisterTicketInfo event,
    Emitter<TicketConfigurationState> emit,
  ) async {
    emit(RegisterTicketInfoLoading());
    try {
      await ticketPriceRegisterUC.call(
        TicketPriceRegisterUCParams(
          ticketId: event.ticketId,
          ticketPrice: event.ticketPrice,
        ),
      );
      emit(RegisterTicketInfoSuccess());
    } catch (e) {
      if (e is MPGException) {
        if (e is TicketAlreadySoldException) {
          emit(TicketAlreadySold());
          return;
        }
      }
      emit(RegisterTicketInfoError(e.toString()));
    }
  }
}
