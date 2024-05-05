import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/domain/repositories/contests_repository.dart';

class UpdateContest {
  final ContestsRepository contestRepository;

  UpdateContest({required this.contestRepository});

  Future<Either<Failure, Unit>> call(Contest contest) async {
    return await contestRepository.updateContest(contest);
  }
}
