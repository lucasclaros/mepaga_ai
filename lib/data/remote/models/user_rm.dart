import 'package:json_annotation/json_annotation.dart';

part 'user_rm.g.dart';

@JsonSerializable()
class UserRM {
  UserRM({
    required this.id,
    this.email,
    required this.profile,
    this.userAuth,
  });

  factory UserRM.fromJson(Map<String, dynamic> json) => _$UserRMFromJson(json);

  Map<String, dynamic> toJson() => _$UserRMToJson(this);

  @JsonKey(name: '_id')
  final String id;
  final ProfileRM profile;

  @JsonKey(includeFromJson: false)
  final String? email;

  @JsonKey(includeFromJson: false)
  final String? userAuth;
}

@JsonSerializable()
class ProfileRM {
  ProfileRM({
    required this.name,
    this.picture,
  });

  factory ProfileRM.fromJson(Map<String, dynamic> json) =>
      _$ProfileRMFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileRMToJson(this);

  final String name;
  final String? picture;
}
