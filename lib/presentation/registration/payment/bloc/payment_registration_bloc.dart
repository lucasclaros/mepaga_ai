import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/pix_register_uc.dart';
import 'package:meta/meta.dart';

part 'payment_registration_event.dart';
part 'payment_registration_state.dart';

class PaymentRegistrationBloc
    extends Bloc<PaymentRegistrationEvent, PaymentRegistrationState> {
  PaymentRegistrationBloc({
    required this.pixRegisterUC,
  }) : super(PaymentRegistrationInitial()) {
    on<RegisterPix>(_mapRegisterPixEventToState);
  }

  final PixRegisterUC pixRegisterUC;

  Future<void> _mapRegisterPixEventToState(
    RegisterPix event,
    Emitter<PaymentRegistrationState> emit,
  ) async {
    emit(RegisterPixLoading());

    try {
      await pixRegisterUC(
        PixRegisterUCParams(
          pixKey: event.pixKey,
          keyType: event.keyType,
        ),
      );
      emit(RegisterPixSuccess());
    } catch (e) {
      if (e is MPGException) {
        emit(RegisterPixError(message: e.message));
      }
    }
  }
}
