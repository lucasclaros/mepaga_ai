import 'package:domain/models/party.dart';

class Ticket {
  Ticket({
    required this.sellerId,
    required this.price,
    required this.sold,
    required this.party,
    required this.id,
  });

  final int? sellerId;
  final double? price;
  final bool? sold;
  final Party? party;
  final String? id;
}
