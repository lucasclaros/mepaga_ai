import 'package:domain/models/party.dart';

class Ticket {
  Ticket({
    required this.sellerId,
    required this.price,
    required this.sold,
    required this.party,
    required this.id,
    required this.platform,
  });

  final int? sellerId;
  final double? price;
  final bool? sold;
  final Party? party;
  final String? id;
  final String? platform;
}
