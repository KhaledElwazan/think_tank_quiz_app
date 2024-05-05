import 'package:think_tank/core/base_entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Attachment extends BaseEntity {
  final String name;
  final String url;
  final AttachmentType type;
  final bool isLocal = true;

  Attachment({
    required this.name,
    required this.url,
    required this.type,
  }) : super();

  @override
  List<Object?> get props => [id, name, url, type, createdAt, updatedAt];
}

enum AttachmentType {
  image,
  video,
  audio,
  file,
  link,
  text,
  pdf,
}
