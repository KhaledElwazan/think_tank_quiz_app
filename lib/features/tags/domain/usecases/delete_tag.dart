import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/tags/domain/repositories/tags_repository.dart';

class DeleteTag {
  final TagsRepository tagsRepository;

  DeleteTag({required this.tagsRepository});

  Future<Either<Failure, Unit>> call(String tagId) async {
    return await tagsRepository.deleteTag(tagId);
  }
}
