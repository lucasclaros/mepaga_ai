import 'package:json_annotation/json_annotation.dart';

part 'user_auth_rm.g.dart';

@JsonSerializable()
class UserAuthRM {
  UserAuthRM({
    required this.auth,
    this.name,
  });

  factory UserAuthRM.fromJson(Map<String, dynamic> json) =>
      _$UserAuthRMFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthRMToJson(this);

  final String auth;
  final String? name;
}
