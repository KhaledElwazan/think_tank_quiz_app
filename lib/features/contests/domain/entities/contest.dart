import 'package:think_tank/core/base_entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Contest extends BaseEntity {
  final String title;
  final String? description;
  List<Question> questions = [];

  Contest({
    required this.title,
    this.description,
    this.questions = const [],
  });

  @override
  List<Object?> get props => [id, title, description, questions];

  @override
  String toString() {
    return 'Contest{id: $id, title: $title, description: $description, questions: $questions}';
  }
}
