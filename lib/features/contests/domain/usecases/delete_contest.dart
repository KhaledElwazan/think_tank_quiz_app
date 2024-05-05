import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/contests/domain/repositories/contests_repository.dart';

class DeleteContest {
  final ContestsRepository contestRepository;

  DeleteContest({required this.contestRepository});

  Future<Either<Failure, Unit>> call(String contestId) async {
    return await contestRepository.deleteContest(contestId);
  }
}
