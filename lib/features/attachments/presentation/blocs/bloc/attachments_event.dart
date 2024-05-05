part of 'attachments_bloc.dart';

sealed class AttachmentsEvent extends Equatable {
  const AttachmentsEvent();

  @override
  List<Object> get props => [];
}

final class GetAttachmentsEvent extends AttachmentsEvent {
  const GetAttachmentsEvent();
}

final class AddAttachmentEvent extends AttachmentsEvent {
  final File file;

  const AddAttachmentEvent(this.file);

  @override
  List<Object> get props => [file];
}

final class DeleteAttachmentEvent extends AttachmentsEvent {
  final Attachment attachment;

  const DeleteAttachmentEvent(this.attachment);

  @override
  List<Object> get props => [attachment];
}

final class UpdateAttachmentEvent extends AttachmentsEvent {
  final Attachment attachment;

  const UpdateAttachmentEvent(this.attachment);

  @override
  List<Object> get props => [attachment];
}
