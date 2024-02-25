import 'package:json_annotation/json_annotation.dart';

part 'payment_charge_rm.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentChargeRM {
  PaymentChargeRM({
    required this.brCode,
    required this.expiry,
    required this.qrImage,
  });

  factory PaymentChargeRM.fromJson(Map<String, dynamic> json) =>
      _$PaymentChargeRMFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentChargeRMToJson(this);

  final String brCode;
  final String expiry;
  final String qrImage;
}
