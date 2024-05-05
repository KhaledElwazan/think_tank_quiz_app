import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/features/questions/data/models/question/question_model.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:uuid/uuid.dart';

abstract class QuestionsLocalDataSource {
  Future<Unit> cacheQuestions(List<QuestionModel> questions);
  Future<List<Question>> getCachedQuestions();
}

const String cachedQuestions = "CACHED_QUESTIONS";

class QuestionsLocalDataSourceImpl extends QuestionsLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuestionsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheQuestions(List<QuestionModel> questions) async {
    final List<dynamic> questionsJson =
        questions.map((question) => question.toJson()).toList();
    await sharedPreferences.setStringList(
      cachedQuestions,
      questionsJson.map((question) => json.encode(question)).toList(),
    );
    return Future.value(unit);
  }

  @override
  Future<List<Question>> getCachedQuestions() async {
    // await createQuestions();

    final List<String>? cachedQuestionsStrings =
        sharedPreferences.getStringList(cachedQuestions);

    if (cachedQuestionsStrings == null) {
      return Future.value([]);
    }

    return Future.value(
      cachedQuestionsStrings
          .map(
            (jsonQuestion) => QuestionModel.fromJson(
              Map<String, dynamic>.from(
                json.decode(jsonQuestion),
              ),
            ),
          )
          .toList(),
    );
  }

  Future<void> createQuestions() async {
    // open json file in the assets folder
    final jsonString =
        await rootBundle.loadString('assets/json/questions.json');
    // convert json string to list
    final List<dynamic> jsonList = await jsonDecode(jsonString);
    // convert list to list of questions

    final List<QuestionModel> questions = jsonList
        .map((jsonQuestion) => QuestionModel.fromJson(
              Map<String, dynamic>.from(jsonQuestion)
                ..addEntries([
                  MapEntry(
                    "createdAt",
                    DateTime.now().toIso8601String(),
                  ),
                  MapEntry(
                    "id",
                    const Uuid().v4(),
                  ),
                  MapEntry(
                    "title",
                    faker.lorem.word(),
                  ),
                ]),
            ))
        .toList();

    await cacheQuestions(questions);
  }
}
