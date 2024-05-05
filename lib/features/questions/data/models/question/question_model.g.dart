// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      title: json['title'] as String,
      statement: json['statement'] as String,
      choices:
          (json['choices'] as List<dynamic>).map((e) => e as String).toList(),
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tag: json['tag'] == null
          ? null
          : TagModel.fromJson(json['tag'] as Map<String, dynamic>),
      correctChoiceIndex: (json['correctChoiceIndex'] as num).toInt(),
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String)
      ..deletedAt = json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String)
      ..id = json['id'] as String;

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'id': instance.id,
      'title': instance.title,
      'statement': instance.statement,
      'choices': instance.choices,
      'attachments': instance.attachments,
      'tag': instance.tag,
      'correctChoiceIndex': instance.correctChoiceIndex,
    };
