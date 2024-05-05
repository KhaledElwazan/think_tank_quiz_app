import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/blocs/questions_bloc/questions_bloc.dart';
import 'package:think_tank/features/questions/presentation/widgets/question_card.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/widgets/multi_tag_select_widget.dart';

class ListOfQuestions extends StatefulWidget {
  const ListOfQuestions({super.key});

  @override
  State<ListOfQuestions> createState() => _ListOfQuestionsState();
}

class _ListOfQuestionsState extends State<ListOfQuestions> {
  List<Tag> filters = [];

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
        } else if (state is CreatedQuestionState ||
            state is UpdatedQuestionState) {
          BlocProvider.of<QuestionsBloc>(context)
              .add(const GetQuestionsEvent());
          return _buildQuestionsList(questions: questions);
        }

        return Center(
          child: Text(
            'no_questions_found'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
      },
    );
  }

  double height = 0;

  Widget _buildQuestionsList({required List<Question> questions}) {
    List<Question> displayedQuestions = questions;

    if (filters.isNotEmpty) {
      displayedQuestions = questions
          .where((question) => filters.contains(question.tag))
          .toList();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              height = height == 0 ? 200 : 0;
            });
          },
          icon: const FaIcon(FontAwesomeIcons.filter),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            height: height,
            width: double.infinity,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 300),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: height == 0 ? 0 : 1,
              child: Visibility(
                visible: height != 0,
                child: MultiTagSelectWidget(onSelected: (tags) {
                  setState(() {
                    filters = tags;
                  });
                }),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: displayedQuestions.map((question) {
              return QuestionCard(question: question);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
