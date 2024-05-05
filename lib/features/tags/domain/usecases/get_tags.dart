import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/domain/repositories/tags_repository.dart';

class GetTags {
  final TagsRepository tagsRepository;

  GetTags({required this.tagsRepository});

  Future<Either<Failure, List<Tag>>> call() async {
    return await tagsRepository.getTags();
  }
}
