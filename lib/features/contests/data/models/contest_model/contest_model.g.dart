// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContestModel _$ContestModelFromJson(Map<String, dynamic> json) => ContestModel(
      title: json['title'] as String,
      description: json['description'] as String?,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )
      ..createdAt = DateTime.parse(json['createdAt'] as String)
      ..updatedAt = json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String)
      ..deletedAt = json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String)
      ..id = json['id'] as String;

Map<String, dynamic> _$ContestModelToJson(ContestModel instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'questions': instance.questions,
    };
