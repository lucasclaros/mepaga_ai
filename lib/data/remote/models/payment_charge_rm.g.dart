// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_charge_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentChargeRM _$PaymentChargeRMFromJson(Map<String, dynamic> json) =>
    PaymentChargeRM(
      brCode: json['br_code'] as String,
      expiry: json['expiry'] as String,
      qrImage: json['qr_image'] as String,
    );

Map<String, dynamic> _$PaymentChargeRMToJson(PaymentChargeRM instance) =>
    <String, dynamic>{
      'br_code': instance.brCode,
      'expiry': instance.expiry,
      'qr_image': instance.qrImage,
    };
