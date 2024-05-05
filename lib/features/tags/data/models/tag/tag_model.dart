import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';

import 'package:json_annotation/json_annotation.dart';

part 'tag_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class TagModel extends Tag {
  TagModel({
    required super.color,
    required super.title,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TagModelToJson(this);

  factory TagModel.fromTag(Tag tag) => TagModel(
        color: tag.color,
        title: tag.title,
      )
        ..id = tag.id
        ..createdAt = tag.createdAt
        ..updatedAt = tag.updatedAt;
}
