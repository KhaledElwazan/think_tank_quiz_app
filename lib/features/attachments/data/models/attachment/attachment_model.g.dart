// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    AttachmentModel(
      name: json['name'] as String,
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
      url: json['url'] as String,
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String)
      ..deletedAt = json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String)
      ..id = json['id'] as String;

Map<String, dynamic> _$AttachmentModelToJson(AttachmentModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'type': _$AttachmentTypeEnumMap[instance.type]!,
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.video: 'video',
  AttachmentType.audio: 'audio',
  AttachmentType.file: 'file',
  AttachmentType.link: 'link',
  AttachmentType.text: 'text',
  AttachmentType.pdf: 'pdf',
};
