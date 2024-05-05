part of 'attachments_bloc.dart';

sealed class AttachmentsState extends Equatable {
  const AttachmentsState();

  @override
  List<Object> get props => [];
}

final class AttachmentsInitial extends AttachmentsState {
  const AttachmentsInitial();

  @override
  List<Object> get props => [];
}

final class AttachmentsLoading extends AttachmentsState {
  const AttachmentsLoading();

  @override
  List<Object> get props => [];
}

final class AttachmentsLoaded extends AttachmentsState {
  final List<Attachment> attachments;

  const AttachmentsLoaded(this.attachments);

  @override
  List<Object> get props => [attachments];
}

final class AttachmentsError extends AttachmentsState {
  final String message;

  const AttachmentsError({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeletingAttachment extends AttachmentsState {
  final Attachment attachment;

  const DeletingAttachment(this.attachment);

  @override
  List<Object> get props => [attachment];
}

final class AttachmentDeleted extends AttachmentsState {
  const AttachmentDeleted();

  @override
  List<Object> get props => [];
}

final class AddingAttachment extends AttachmentsState {
  const AddingAttachment();

  @override
  List<Object> get props => [];
}

final class AttachmentAdded extends AttachmentsState {
  final Attachment attachment;

  const AttachmentAdded({required this.attachment});

  @override
  List<Object> get props => [attachment];
}

final class UpdatingAttachment extends AttachmentsState {
  final Attachment attachment;

  const UpdatingAttachment(this.attachment);

  @override
  List<Object> get props => [attachment];
}

final class AttachmentUpdated extends AttachmentsState {
  final Attachment attachment;

  const AttachmentUpdated(this.attachment);

  @override
  List<Object> get props => [attachment];
}
