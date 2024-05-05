import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/domain/repositories/contests_repository.dart';

class GetAllContests {
  final ContestsRepository contestRepository;

  GetAllContests({required this.contestRepository});

  Future<Either<Failure, List<Contest>>> call() async {
    return await contestRepository.getAllContests();
  }
}
