import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class AttachmentModel extends Attachment {
  AttachmentModel({
    required super.name,
    required super.type,
    required super.url,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);

  factory AttachmentModel.fromAttachment(Attachment attachment) {
    return AttachmentModel(
      name: attachment.name,
      type: attachment.type,
      url: attachment.url,
    )
      ..id = attachment.id
      ..createdAt = attachment.createdAt
      ..updatedAt = attachment.updatedAt;
  }
}
