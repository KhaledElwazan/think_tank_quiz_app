import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/questions/domain/repositories/questions_repository.dart';

class DeleteQuestion {
  final QuestionsRepository repository;

  DeleteQuestion({required this.repository});

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteQuestion(id);
  }
}
