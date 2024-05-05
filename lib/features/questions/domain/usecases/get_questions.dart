import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/domain/repositories/questions_repository.dart';

class GetQuestions {
  final QuestionsRepository repository;

  GetQuestions({required this.repository});

  Future<Either<Failure, List<Question>>> call() async {
    return await repository.getQuestions();
  }
}
