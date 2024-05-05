import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/features/tags/data/models/tag/tag_model.dart';

abstract class TagsLocalDataSource {
  Future<List<TagModel>> getTags();
  Future<Unit> cacheTags(List<TagModel> tags);
}

const String cachedTags = 'CACHED_TAGS';

class TagsLocalDataSourceImpl implements TagsLocalDataSource {
  final SharedPreferences sharedPreferences;

  TagsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TagModel>> getTags() {
    final jsonString = sharedPreferences.getStringList(cachedTags);
    if (jsonString != null) {
      final List<TagModel> tags = [];
      final List<dynamic> jsonList =
          jsonString.map((e) => json.decode(e)).toList();
      for (var element in jsonList) {
        tags.add(TagModel.fromJson(element));
      }
      return Future.value(tags);
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<Unit> cacheTags(List<TagModel> tags) async {
    final List<String> jsonList =
        tags.map((tag) => json.encode(tag.toJson())).toList();
    await sharedPreferences.setStringList(cachedTags, jsonList);
    return Future.value(unit);
  }
}
