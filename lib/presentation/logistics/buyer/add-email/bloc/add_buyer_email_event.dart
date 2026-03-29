part of 'add_buyer_email_bloc.dart';

@immutable
abstract class AddBuyerEmailEvent {}

class CheckBuyerEmail extends AddBuyerEmailEvent {
  CheckBuyerEmail({
    required this.platform,
    required this.email,
  });

  final String platform;
  final String email;
}
