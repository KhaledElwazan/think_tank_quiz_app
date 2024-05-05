import 'package:dartz/dartz.dart';
import 'package:think_tank/core/error/exceptions.dart';
import 'package:think_tank/core/error/failure.dart';
import 'package:think_tank/features/questions/data/data_sources/questions_local_data_source.dart';
import 'package:think_tank/features/questions/data/models/question/question_model.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl extends QuestionsRepository {
  final QuestionsLocalDataSource questionsLocalDataSource;

  QuestionsRepositoryImpl({required this.questionsLocalDataSource});

  @override
  Future<Either<Failure, Unit>> createQuestion(Question question) async {
    try {
      final List<Question> questions =
          await questionsLocalDataSource.getCachedQuestions();
      questions.add(QuestionModel.fromQuestion(question));
      dynamic questionModels =
          questions.map((e) => QuestionModel.fromQuestion(e)).toList();
      return Right(
          await questionsLocalDataSource.cacheQuestions(questionModels));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteQuestion(String id) async {
    try {
      List<Question> questions =
          await questionsLocalDataSource.getCachedQuestions();
      int index = questions.indexWhere((element) => element.id == id);

      if (index == -1) {
        return Left(CacheFailure());
      }

      questions.removeAt(index);

      dynamic questionModels =
          questions.map((e) => QuestionModel.fromQuestion(e)).toList();
      return Right(
          await questionsLocalDataSource.cacheQuestions(questionModels));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestions() async {
    try {
      List<Question> questions =
          await questionsLocalDataSource.getCachedQuestions();
      return Right(questions);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateQuestion(Question question) async {
    try {
      List<Question> questions =
          await questionsLocalDataSource.getCachedQuestions();

      int index = questions.indexWhere((element) => element.id == question.id);

      if (index == -1) {
        return Left(CacheFailure());
      }

      questions[index] = QuestionModel.fromQuestion(question);
      dynamic questionModels =
          questions.map((e) => QuestionModel.fromQuestion(e)).toList();

      return Right(
          await questionsLocalDataSource.cacheQuestions(questionModels));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
