import 'package:bloc/bloc.dart';
import 'package:domain/models/payment_charge.dart';
import 'package:domain/use_cases/get_payment_charge_uc.dart';
import 'package:meta/meta.dart';

part 'payment_charge_event.dart';
part 'payment_charge_state.dart';

class PaymentChargeBloc extends Bloc<PaymentChargeEvent, PaymentChargeState> {
  PaymentChargeBloc({
    required this.getPaymentChargeUC,
  }) : super(PaymentChargeInitial()) {
    on<GetPaymentChargeEvent>(_mapGetPaymentChargeEventToState);
  }

  final GetPaymentChargeUC getPaymentChargeUC;

  Future<void> _mapGetPaymentChargeEventToState(
    GetPaymentChargeEvent event,
    Emitter<PaymentChargeState> emit,
  ) async {
    emit(GetPaymentChargeLoading());

    try {
      final paymentCharge = await getPaymentChargeUC.call(
        GetPaymentChargeUCParams(
          ticketId: event.ticketId,
          transferEmail: event.transferEmail,
        ),
      );
      emit(GetPaymentChargeSuccess(paymentCharge: paymentCharge));
    } catch (e) {
      emit(GetPaymentChargeFailure(error: e.toString()));
    }
  }
}
