part of 'add_buyer_email_bloc.dart';

@immutable
abstract class AddBuyerEmailState {}

class AddBuyerEmailInitial extends AddBuyerEmailState {}

class CheckBuyerEmailSuccess extends AddBuyerEmailState {}

class CheckBuyerEmailLoading extends AddBuyerEmailState {}

class CheckBuyerEmailError extends AddBuyerEmailState {
  CheckBuyerEmailError({required this.message});

  final String message;
}

class CheckBuyerEmailSuccessNoAssociation extends AddBuyerEmailState {
  CheckBuyerEmailSuccessNoAssociation({required this.platform});

  final String platform;
}

class CheckBuyerEmailSuccessNoAccount extends AddBuyerEmailState {}

class CheckBuyerEmailSuccessEmailExists extends AddBuyerEmailState {}
