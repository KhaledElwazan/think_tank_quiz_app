import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/domain/repositories/tags_repository.dart';

class UpdateTag {
  final TagsRepository tagsRepository;

  UpdateTag({required this.tagsRepository});

  Future<Either<Failure, Unit>> call(Tag tag) async {
    return await tagsRepository.updateTag(tag);
  }
}
