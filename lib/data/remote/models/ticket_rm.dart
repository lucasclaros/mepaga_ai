import 'package:json_annotation/json_annotation.dart';
import 'package:mepaga_ai/data/remote/models/party_rm.dart';

part 'ticket_rm.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketRM {
  TicketRM({
    this.sellerId,
    this.price,
    this.sold,
    this.party,
    this.id,
  });

  factory TicketRM.fromJson(Map<String, dynamic> json) =>
      _$TicketRMFromJson(json);

  Map<String, dynamic> toJson() => _$TicketRMToJson(this);

  final int? sellerId;
  final double? price;
  final bool? sold;
  final PartyRM? party;
  final String? id;
}
