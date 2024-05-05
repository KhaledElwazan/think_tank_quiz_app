part of 'questions_bloc.dart';

sealed class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

final class QuestionsInitial extends QuestionsState {}

class LoadingQuestions extends QuestionsState {
  const LoadingQuestions();

  @override
  List<Object> get props => [];
}

class LoadedQuestionsState extends QuestionsState {
  final List<Question> questions;

  const LoadedQuestionsState({required this.questions});

  @override
  List<Object> get props => [questions];
}

class ErrorLoadingQuestions extends QuestionsState {
  final String message;
  const ErrorLoadingQuestions({required this.message});
  @override
  List<Object> get props => [message];
}

class CreatingQuestionState extends QuestionsState {
  const CreatingQuestionState();

  @override
  List<Object> get props => [];
}

class CreatedQuestionState extends QuestionsState {
  final Question question;
  const CreatedQuestionState({required this.question});

  @override
  List<Object> get props => [];
}

class UpdatingQuestionState extends QuestionsState {
  const UpdatingQuestionState();

  @override
  List<Object> get props => [];
}

class UpdatedQuestionState extends QuestionsState {
  final Question question;
  const UpdatedQuestionState({required this.question});

  @override
  List<Object> get props => [];
}

class DeletingQuestionState extends QuestionsState {
  const DeletingQuestionState();

  @override
  List<Object> get props => [];
}

class DeletedQuestionState extends QuestionsState {
  final Question question;
  const DeletedQuestionState({required this.question});

  @override
  List<Object> get props => [];
}
