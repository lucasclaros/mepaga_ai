// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRM _$UserRMFromJson(Map<String, dynamic> json) => UserRM(
  name: json['name'] as String,
  email: json['email'] as String,
  pixKey: json['pix_key'] as String?,
);

Map<String, dynamic> _$UserRMToJson(UserRM instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'pix_key': instance.pixKey,
};
