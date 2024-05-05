import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/domain/repositories/contests_repository.dart';

class CreateContest {
  final ContestsRepository contestsRepository;

  CreateContest({required this.contestsRepository});

  Future<Either<Failure, Unit>> call(Contest contest) async {
    return await contestsRepository.createContest(contest);
  }
}
