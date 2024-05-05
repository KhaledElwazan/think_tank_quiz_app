import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/blocs/questions_bloc/questions_bloc.dart';
import 'package:think_tank/features/questions/presentation/widgets/question_card.dart';

class ListOfSelectableQuestions extends StatefulWidget {
  // create onSelect callback
  final Function(List<Question>) onSelect;
  final List<Question> selected;
  const ListOfSelectableQuestions(
      {super.key, required this.onSelect, required this.selected});

  @override
  State<ListOfSelectableQuestions> createState() =>
      _ListOfSelectableQuestionsState();
}

class _ListOfSelectableQuestionsState extends State<ListOfSelectableQuestions> {
  List<Question> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    selectedQuestions = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        List<Question> questions = [];
        if (state is LoadedQuestionsState && state.questions.isNotEmpty) {
          questions.addAll(state.questions);
          return _buildQuestionsList(questions: questions);
        } else if (state is ErrorLoadingQuestions) {
          //TODO: display something up loading error
        } else if (state is CreatedQuestionState) {
          questions.add(state.question);
          return _buildQuestionsList(questions: questions);
        } else if (state is UpdatedQuestionState) {
          BlocProvider.of<QuestionsBloc>(context)
              .add(const GetQuestionsEvent());
        }

        return Center(
          child: Text(
            'no_questions_found.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }

  Widget _buildQuestionsList({required List<Question> questions}) {
    return ListView(
      children: questions.map((question) {
        return ListTile(
          leading: Checkbox(
            value: selectedQuestions.contains(question),
            onChanged: (value) {
              setState(() {
                if (selectedQuestions.contains(question)) {
                  selectedQuestions.remove(question);
                } else {
                  selectedQuestions.add(question);
                }
              });

              widget.onSelect(selectedQuestions);
            },
          ),
          title: QuestionCard(question: question),
        );
      }).toList(),
    );
  }
}
