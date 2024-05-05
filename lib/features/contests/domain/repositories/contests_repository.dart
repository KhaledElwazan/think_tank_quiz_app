import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';

abstract class ContestsRepository {
  Future<Either<Failure, List<Contest>>> getAllContests();
  Future<Either<Failure, Unit>> deleteContest(String id);
  Future<Either<Failure, Unit>> updateContest(Contest contest);
  Future<Either<Failure, Unit>> createContest(Contest contest);
}
