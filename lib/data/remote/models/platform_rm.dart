import 'package:json_annotation/json_annotation.dart';

part 'platform_rm.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PlatformRM {
  PlatformRM({
    required this.platform,
    required this.associated,
  });

  factory PlatformRM.fromJson(Map<String, dynamic> json) =>
      _$PlatformRMFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformRMToJson(this);

  final String platform;
  final bool associated;
}
