// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_remote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRemote _$UserRemoteFromJson(Map<String, dynamic> json) => UserRemote(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      surname: json['surname'] as String,
      secondName: json['second_name'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$UserRemoteToJson(UserRemote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'surname': instance.surname,
      'second_name': instance.secondName,
      'phone': instance.phone,
      'password': instance.password,
      'active': instance.active,
    };
