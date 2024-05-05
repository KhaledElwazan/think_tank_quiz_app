import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';

class DeleteAttachment {
  final AttachmentsRepository attachmentsRepository;

  DeleteAttachment({required this.attachmentsRepository});

  Future<Either<Failure, Unit>> call(String attachmentId) async {
    return await attachmentsRepository.deleteAttachment(attachmentId);
  }
}
