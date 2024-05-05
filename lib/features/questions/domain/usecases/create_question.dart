import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/domain/repositories/questions_repository.dart';

class CreateQuestion {
  final QuestionsRepository repository;

  CreateQuestion({required this.repository});

  Future<Either<Failure, Unit>> call(Question question) async {
    return await repository.createQuestion(question);
  }
}
