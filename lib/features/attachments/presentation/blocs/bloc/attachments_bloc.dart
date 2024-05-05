import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';

part 'attachments_event.dart';
part 'attachments_state.dart';

class AttachmentsBloc extends Bloc<AttachmentsEvent, AttachmentsState> {
  final AttachmentsRepository attachmentsRepository;

  AttachmentsBloc({required this.attachmentsRepository})
      : super(const AttachmentsInitial()) {
    on<AttachmentsEvent>((event, emit) async {
      if (event is GetAttachmentsEvent) {
        emit(const AttachmentsLoading());
        final failureOrAttachments =
            await attachmentsRepository.getAttachments();

        failureOrAttachments.fold((failure) {
          emit(const AttachmentsError(message: 'Error loading attachments'));
        }, (attachments) {
          emit(AttachmentsLoaded(attachments));
        });
      } else if (event is DeleteAttachmentEvent) {
        emit(DeletingAttachment(event.attachment));

        final failureOrDeleted =
            await attachmentsRepository.deleteAttachment(event.attachment.id);

        failureOrDeleted.fold(
          (failure) => emit(
              const AttachmentsError(message: 'Error deleting attachment')),
          (attachment) => emit(
            const AttachmentDeleted(),
          ),
        );
      } else if (event is AddAttachmentEvent) {
        emit(const AddingAttachment());

        final failureOrAttachment =
            await attachmentsRepository.createAttachment(event.file);
        failureOrAttachment.fold(
          (failure) =>
              emit(const AttachmentsError(message: 'Error adding attachment')),
          (attachment) => emit(
            AttachmentAdded(attachment: attachment),
          ),
        );
      }
    });
  }
}
