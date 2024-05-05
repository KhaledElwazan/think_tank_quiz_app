import 'package:think_tank/core/base_entity/base_entity.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Question extends BaseEntity {
  final String title;
  final String statement;
  final List<String> choices;
  final List<Attachment> attachments;
  final Tag? tag;
  final int correctChoiceIndex;
  final int time4Answer = 30;

  Question({
    required this.title,
    required this.statement,
    required this.choices,
    this.attachments = const [],
    required this.tag,
    required this.correctChoiceIndex,
  }) : super();

  @override
  List<Object?> get props => [
        id,
        title,
        statement,
        choices,
        attachments,
        tag,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'Question { id: $id, title: $title, statement: $statement, choices: $choices, attachments: $attachments, tag: $tag, correctChoiceIndex: $correctChoiceIndex, time4Answer: $time4Answer }';
  }
}
