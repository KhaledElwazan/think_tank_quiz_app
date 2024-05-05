import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';

abstract class AttachmentsRepository {
  Future<Either<Failure, List<Attachment>>> getAttachments();
  Future<Either<Failure, Attachment>> createAttachment(File file);
  Future<Either<Failure, Unit>> deleteAttachment(String id);
  Future<Either<Failure, Unit>> updateAttachment(Attachment attachment);
}
