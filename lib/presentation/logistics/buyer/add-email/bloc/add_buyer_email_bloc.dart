import 'package:bloc/bloc.dart';
import 'package:domain/exceptions.dart';
import 'package:domain/use_cases/validate_byma_email_uc.dart';
import 'package:meta/meta.dart';

part 'add_buyer_email_event.dart';
part 'add_buyer_email_state.dart';

class AddBuyerEmailBloc extends Bloc<AddBuyerEmailEvent, AddBuyerEmailState> {
  AddBuyerEmailBloc({
    required this.validateBymaEmailUC,
  }) : super(AddBuyerEmailInitial()) {
    on<CheckBuyerEmail>(_mapCheckUserPlatformToState);
  }

  final ValidateBymaEmailUC validateBymaEmailUC;

  Future<void> _mapCheckUserPlatformToState(
    CheckBuyerEmail event,
    Emitter<AddBuyerEmailState> emit,
  ) async {
    emit(CheckBuyerEmailLoading());

    try {
      await validateBymaEmailUC(ValidateBymaEmailUCParams(email: event.email));
      emit(CheckBuyerEmailSuccess());
    } catch (e) {
      if (e is FoundAccountNoAssociation) {
        return emit(
          CheckBuyerEmailSuccessNoAssociation(platform: event.platform),
        );
      }

      if (e is NoAccountFound) {
        return emit(CheckBuyerEmailSuccessNoAccount());
      }

      if (e is EmailAlreadyExistsException) {
        return emit(CheckBuyerEmailSuccessEmailExists());
      }

      emit(CheckBuyerEmailError(message: e.toString()));
    }
  }
}
