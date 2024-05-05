import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';

abstract class TagsRepository {
  Future<Either<Failure, List<Tag>>> getTags();
  Future<Either<Failure, Unit>> createTag(Tag tag);
  Future<Either<Failure, Unit>> deleteTag(String id);
  Future<Either<Failure, Unit>> updateTag(Tag tag);
}
