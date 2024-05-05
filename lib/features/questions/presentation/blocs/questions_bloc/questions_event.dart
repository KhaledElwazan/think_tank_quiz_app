part of 'questions_bloc.dart';

sealed class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}

class GetQuestionsEvent extends QuestionsEvent {
  const GetQuestionsEvent();

  @override
  List<Object> get props => [];
}

class RefreshQuestionsEvent extends QuestionsEvent {
  const RefreshQuestionsEvent();

  @override
  List<Object> get props => [];
}

class UpdateQuestionEvent extends QuestionsEvent {
  final Question question;
  const UpdateQuestionEvent({required this.question});

  @override
  List<Object> get props => [question];
}

class CreateQuestionEvent extends QuestionsEvent {
  final Question question;
  const CreateQuestionEvent({required this.question});

  @override
  List<Object> get props => [question];
}

class DeleteQuestionEvent extends QuestionsEvent {
  final Question question;
  const DeleteQuestionEvent({required this.question});

  @override
  List<Object> get props => [question];
}
