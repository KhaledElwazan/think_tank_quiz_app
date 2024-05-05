import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/exceptions.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/tags/data/data_sources/tags_local_data_source.dart';
import 'package:think_tank/features/tags/data/models/tag/tag_model.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/domain/repositories/tags_repository.dart';

class TagsRepositoryImpl extends TagsRepository {
  final TagsLocalDataSource tagsLocalDataSource;

  TagsRepositoryImpl({required this.tagsLocalDataSource});

  @override
  Future<Either<Failure, Unit>> createTag(Tag tag) async {
    try {
      List<TagModel> tags = await tagsLocalDataSource.getTags();
      tags.add(TagModel.fromTag(tag));
      await tagsLocalDataSource.cacheTags(tags);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTag(String id) async {
    try {
      List<TagModel> tags = await tagsLocalDataSource.getTags();
      int index = tags.indexWhere((element) => element.id == id);
      if (index != -1) {
        tags.removeAt(index);
        await tagsLocalDataSource.cacheTags(tags);
        return const Right(unit);
      } else {
        return Left(CacheFailure());
      }
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Tag>>> getTags() async {
    try {
      List<Tag> tags = await tagsLocalDataSource.getTags();
      return Right(tags);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTag(Tag tag) async {
    try {
      List<TagModel> tags = await tagsLocalDataSource.getTags();

      int index = tags.indexWhere((element) => element.id == tag.id);
      if (index != -1) {
        tags[index] = TagModel.fromTag(tag);
        await tagsLocalDataSource.cacheTags(tags);
        return const Right(unit);
      } else {
        return Left(CacheFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
