// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseEntity _$BaseEntityFromJson(Map<String, dynamic> json) => BaseEntity(
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..id = json['id'] as String;

Map<String, dynamic> _$BaseEntityToJson(BaseEntity instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'id': instance.id,
    };
