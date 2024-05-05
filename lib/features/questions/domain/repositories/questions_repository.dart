import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, List<Question>>> getQuestions();
  Future<Either<Failure, Unit>> createQuestion(Question question);
  Future<Either<Failure, Unit>> deleteQuestion(String id);
  Future<Either<Failure, Unit>> updateQuestion(Question question);
}
