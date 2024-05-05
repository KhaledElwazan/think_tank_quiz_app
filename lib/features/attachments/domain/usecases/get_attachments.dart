import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';

class GetAttachments {
  final AttachmentsRepository attachmentsRepository;

  GetAttachments({required this.attachmentsRepository});

  Future<Either<Failure, List<Attachment>>> call() async {
    return await attachmentsRepository.getAttachments();
  }
}
