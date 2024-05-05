import 'package:think_tank/core/base_entity/base_entity.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Tag extends BaseEntity {
  final String title;
  final int color;

  Tag({
    required this.title,
    required this.color,
  });

  @override
  List<Object?> get props => [title, color];

  @override
  String toString() {
    return 'Tag{id: $id, title: $title, color: $color, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
