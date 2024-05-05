import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/exceptions.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/contests/data/data_sources/contest_local_data_source.dart';
import 'package:think_tank/features/contests/data/models/contest_model/contest_model.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/domain/repositories/contests_repository.dart';

class ContestsRepositoryImpl extends ContestsRepository {
  final ContestsLocalDataSource contestsLocalDataSource;

  ContestsRepositoryImpl({required this.contestsLocalDataSource});

  @override
  Future<Either<Failure, Unit>> createContest(Contest contest) async {
    try {
      List<ContestModel> contests = await contestsLocalDataSource.getContests();
      contests.add(ContestModel.fromContest(contest));
      await contestsLocalDataSource.cacheContests(contests);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteContest(String id) async {
    try {
      List<ContestModel> contests = await contestsLocalDataSource.getContests();
      contests.removeWhere((element) => element.id == id);
      await contestsLocalDataSource.cacheContests(contests);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contest>>> getAllContests() async {
    try {
      final contests = await contestsLocalDataSource.getContests();
      return Right(contests);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateContest(Contest contest) async {
    try {
      final List<ContestModel> contests =
          await contestsLocalDataSource.getContests();
      final index = contests.indexWhere((element) => element.id == contest.id);

      if (index != -1) {
        contests[index] = ContestModel.fromContest(contest);
        await contestsLocalDataSource.cacheContests(contests);
        return const Right(unit);
      } else {
        return Left(CacheFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
