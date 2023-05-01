// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRM _$UserRMFromJson(Map<String, dynamic> json) => UserRM(
      id: json['_id'] as String,
      profile: ProfileRM.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRMToJson(UserRM instance) => <String, dynamic>{
      '_id': instance.id,
      'profile': instance.profile,
    };

ProfileRM _$ProfileRMFromJson(Map<String, dynamic> json) => ProfileRM(
      name: json['name'] as String,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$ProfileRMToJson(ProfileRM instance) => <String, dynamic>{
      'name': instance.name,
      'picture': instance.picture,
    };
