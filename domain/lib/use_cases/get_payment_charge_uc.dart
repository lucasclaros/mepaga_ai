import 'package:domain/models/payment_charge.dart';
import 'package:domain/repositories/user_repository_interface.dart';
import 'package:domain/use_cases/use_case.dart';

class GetPaymentChargeUC
    extends UseCase<GetPaymentChargeUCParams, PaymentCharge> {
  GetPaymentChargeUC({
    required super.logger,
    required this.repository,
  });

  final IUserRepositoryInterface repository;

  @override
  Future<PaymentCharge> rawCall(GetPaymentChargeUCParams params) =>
      repository.getPaymentCharge(
        ticketId: params.ticketId,
        transferEmail: params.transferEmail,
      );
}

class GetPaymentChargeUCParams {
  GetPaymentChargeUCParams({
    required this.transferEmail,
    required this.ticketId,
  });

  final String transferEmail;
  final String ticketId;
}
