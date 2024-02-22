// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketRM _$TicketRMFromJson(Map<String, dynamic> json) => TicketRM(
      sellerId: json['seller_id'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      sold: json['sold'] as bool?,
      party: json['party'] == null
          ? null
          : PartyRM.fromJson(json['party'] as Map<String, dynamic>),
      id: json['id'] as String?,
      platform: json['platform'] as String?,
    );

Map<String, dynamic> _$TicketRMToJson(TicketRM instance) => <String, dynamic>{
      'seller_id': instance.sellerId,
      'price': instance.price,
      'sold': instance.sold,
      'party': instance.party,
      'id': instance.id,
      'platform': instance.platform,
    };
