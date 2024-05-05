import 'package:think_tank/features/attachments/data/models/attachment/attachment_model.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:think_tank/features/tags/data/models/tag/tag_model.dart';

part 'question_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class QuestionModel extends Question {
  QuestionModel({
    required super.title,
    required super.statement,
    required super.choices,
    super.attachments = const [],
    required super.tag,
    required super.correctChoiceIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  factory QuestionModel.fromQuestion(Question question) {
    return QuestionModel(
        title: question.title,
        statement: question.statement,
        choices: question.choices,
        attachments: question.attachments,
        correctChoiceIndex: question.correctChoiceIndex,
        tag: question.tag)
      ..id = question.id
      ..createdAt = question.createdAt
      ..updatedAt = question.updatedAt;
  }
}
