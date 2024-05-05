import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:think_tank/features/questions/data/models/question/question_model.dart';

part 'contest_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class ContestModel extends Contest {
  ContestModel({
    required super.title,
    super.description,
    super.questions,
  });

  factory ContestModel.fromJson(Map<String, dynamic> json) =>
      _$ContestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContestModelToJson(this);

  factory ContestModel.fromContest(Contest contest) {
    return ContestModel(
      title: contest.title,
      description: contest.description,
      questions: contest.questions
          .map((question) => QuestionModel.fromQuestion(question))
          .toList(),
    )
      ..id = contest.id
      ..createdAt = contest.createdAt
      ..updatedAt = contest.updatedAt;
  }
}
