import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/domain/usecases/create_question.dart';
import 'package:think_tank/features/questions/domain/usecases/delete_question.dart';
import 'package:think_tank/features/questions/domain/usecases/get_questions.dart';
import 'package:think_tank/features/questions/domain/usecases/update_question.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final GetQuestions getQuestions;
  final UpdateQuestion updateQuestion;
  final DeleteQuestion deleteQuestion;
  final CreateQuestion createQuestion;

  QuestionsBloc({
    required this.getQuestions,
    required this.updateQuestion,
    required this.deleteQuestion,
    required this.createQuestion,
  }) : super(QuestionsInitial()) {
    on<QuestionsEvent>((event, emit) async {
      switch (event) {
        case RefreshQuestionsEvent():
        case GetQuestionsEvent():
          emit(const LoadingQuestions());
          final failureOrQuestions = await getQuestions();
          failureOrQuestions.fold(
            (failure) => emit(
                const ErrorLoadingQuestions(message: "error loading question")),
            (questions) => emit(LoadedQuestionsState(questions: questions)),
          );
          break;

        case UpdateQuestionEvent():
          emit(const UpdatingQuestionState());
          final failureOrUpdate = await updateQuestion(event.question);
          failureOrUpdate.fold(
              (failure) => emit(
                    const ErrorLoadingQuestions(
                        message: "error updating question"),
                  ),
              (question) => emit(
                    UpdatedQuestionState(question: event.question),
                  ));

        case CreateQuestionEvent():
          emit(const CreatingQuestionState());
          final failureOrCreated = await createQuestion(event.question);

          failureOrCreated.fold(
              (failure) => emit(
                    const ErrorLoadingQuestions(
                        message: "error creating question"),
                  ),
              (question) => emit(
                    CreatedQuestionState(question: event.question),
                  ));
        case DeleteQuestionEvent():
          emit(const DeletingQuestionState());
          final failureOrDeleted = await deleteQuestion(event.question.id);
          failureOrDeleted.fold(
            (failure) => emit(
              const ErrorLoadingQuestions(message: "error deleting question"),
            ),
            (question) => emit(
              DeletedQuestionState(question: event.question),
            ),
          );
      }
    });
  }
}
