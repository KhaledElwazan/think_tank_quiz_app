import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/features/attachments/data/models/attachment/attachment_model.dart';

abstract class AttachmentsLocalDataSource {
  Future<List<AttachmentModel>> getAttachments();
  Future<Unit> cacheAttachments(List<AttachmentModel> attachments);
}

const String cachedAttachments = 'CACHED_ATTACHMENTS';

final class AttachmentsLocalDataSourceImpl
    implements AttachmentsLocalDataSource {
  final SharedPreferences sharedPreferences;

  AttachmentsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheAttachments(List<AttachmentModel> attachments) async {
    final List<String> jsonList = attachments
        .map((attachment) => json.encode(attachment.toJson()))
        .toList();
    await sharedPreferences.setStringList(cachedAttachments, jsonList);
    return Future.value(unit);
  }

  @override
  Future<List<AttachmentModel>> getAttachments() async {
    final jsonString = sharedPreferences.getStringList(cachedAttachments);

    if (jsonString != null) {
      List<AttachmentModel> attachments = [];
      List<dynamic> jsonList = jsonString.map((e) => json.decode(e)).toList();
      for (var element in jsonList) {
        attachments.add(AttachmentModel.fromJson(element));
      }
      return Future.value(attachments);
    } else {
      return Future.value([]);
    }
  }
}
