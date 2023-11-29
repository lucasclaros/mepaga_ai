import 'package:json_annotation/json_annotation.dart';

part 'user_rm.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRM {
  UserRM({
    required this.name,
    required this.email,
    this.pixKey,
  });

  factory UserRM.fromJson(Map<String, dynamic> json) => _$UserRMFromJson(json);

  Map<String, dynamic> toJson() => _$UserRMToJson(this);

  final String name;
  final String email;
  final String? pixKey;
}
