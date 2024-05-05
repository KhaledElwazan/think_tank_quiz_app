import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:think_tank/core/error/exceptions.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/attachments/data/data_sources/attachments_local_data_source.dart';
import 'package:think_tank/features/attachments/data/models/attachment/attachment_model.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';

final class AttachmentsRepositoryImpl extends AttachmentsRepository {
  final AttachmentsLocalDataSource attachmentsLocalDataSource;

  AttachmentsRepositoryImpl({required this.attachmentsLocalDataSource});

  @override
  Future<Either<Failure, Attachment>> createAttachment(File file) async {
    try {
      // get the path of app directory
      final directory = await getApplicationDocumentsDirectory();

      final cachedFile =
          await file.copy('${directory.path}/${file.path.split('/').last}');

      // get cachedFile url
      String url = cachedFile.path;
      String fileName = cachedFile.path.split('/').last;

      final typeAsString = lookupMimeType(fileName)!.split('/').first;
      final AttachmentType attachmentType;

      switch (typeAsString) {
        case 'image':
          attachmentType = AttachmentType.image;
          break;
        case 'video':
          attachmentType = AttachmentType.video;
          break;
        case 'audio':
          attachmentType = AttachmentType.audio;
          break;
        case 'pdf':
          attachmentType = AttachmentType.pdf;
          break;
        default:
          attachmentType = AttachmentType.file;
      }

      AttachmentModel attachment = AttachmentModel(
        url: url,
        name: fileName,
        type: attachmentType,
      );

      List<AttachmentModel> attachments =
          await attachmentsLocalDataSource.getAttachments();
      attachments.add(attachment);
      await attachmentsLocalDataSource.cacheAttachments(attachments);
      return Right(attachment);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAttachment(String id) async {
    try {
      List<AttachmentModel> attachments =
          await attachmentsLocalDataSource.getAttachments();
      attachments.removeWhere((element) => element.id == id);
      await attachmentsLocalDataSource.cacheAttachments(attachments);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Attachment>>> getAttachments() async {
    try {
      List<Attachment> attachments =
          await attachmentsLocalDataSource.getAttachments();
      return Right(attachments);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateAttachment(Attachment attachment) async {
    try {
      List<AttachmentModel> attachments =
          await attachmentsLocalDataSource.getAttachments();
      attachments.removeWhere((element) => element.id == attachment.id);
      attachments.add(AttachmentModel.fromAttachment(attachment));
      await attachmentsLocalDataSource.cacheAttachments(attachments);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
