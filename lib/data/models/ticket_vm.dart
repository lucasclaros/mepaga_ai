import 'package:mepaga_ai/data/models/party_vm.dart';

class TicketVM {
  TicketVM({
    required this.sellerId,
    required this.price,
    required this.sold,
    required this.party,
    required this.id,
  });

  final int? sellerId;
  final double? price;
  final bool? sold;
  final PartyVM? party;
  final String? id;
}
