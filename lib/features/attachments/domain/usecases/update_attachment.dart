import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';

class UpdateAttachment {
  final AttachmentsRepository attachmentRepository;

  UpdateAttachment({required this.attachmentRepository});

  Future<Either<Failure, Unit>> call(Attachment attachment) async {
    return await attachmentRepository.updateAttachment(attachment);
  }
}
