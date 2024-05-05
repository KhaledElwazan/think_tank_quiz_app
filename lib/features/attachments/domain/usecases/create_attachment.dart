import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';

class CreateAttachment {
  final AttachmentsRepository attachmentsRepository;

  CreateAttachment({required this.attachmentsRepository});

  Future<Either<Failure, Attachment>> call(File file) async {
    return await attachmentsRepository.createAttachment(file);
  }
}
