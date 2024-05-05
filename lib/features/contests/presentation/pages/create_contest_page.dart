import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/presentation/blocs/contest_bloc.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/widgets/list_of_selectable_questions.dart';
import 'package:think_tank/features/questions/presentation/widgets/question_card.dart';

class CreateContestPage extends StatefulWidget {
  static const routeName = '/create-contest';
  final Contest? contest;
  const CreateContestPage({super.key, this.contest});

  @override
  State<CreateContestPage> createState() => _CreateContestPageState();
}

class _CreateContestPageState extends State<CreateContestPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<Question> cachedQuestions = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.contest != null) {
      titleController.text = widget.contest!.title;
      descriptionController.text = widget.contest!.description ?? '';
      cachedQuestions = widget.contest!.questions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Contest contest = Contest(
              title: titleController.text,
              description: descriptionController.text,
              questions: cachedQuestions,
            );

            if (widget.contest != null) {
              contest.id = widget.contest!.id;
              BlocProvider.of<ContestBloc>(context).add(
                UpdateContestEvent(contest: contest),
              );
            } else {
              BlocProvider.of<ContestBloc>(context).add(
                CreateContestEvent(contest: contest),
              );
            }

            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: const FaIcon(FontAwesomeIcons.floppyDisk),
      ),
      appBar: AppBar(
        title: Text('create_contest'.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                      top: 15,
                      left: 5,
                      right: 5,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            label: Text("title".tr()),
                            border: const OutlineInputBorder(),
                          ),
                          maxLength: 50,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          maxLines: 3,
                          controller: descriptionController,
                          decoration: InputDecoration(
                            label: Text("description".tr()),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'questions'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.left,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SafeArea(
                            child: ListOfSelectableQuestions(
                              selected: cachedQuestions,
                              onSelect: (questions) {
                                setState(() {
                                  cachedQuestions = questions;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      icon: const FaIcon(FontAwesomeIcons.plus),
                    )
                  ],
                ),
              ),
              if (cachedQuestions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...List.generate(
                        cachedQuestions.length,
                        (index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuestionCard(
                              question: cachedQuestions[index],
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       cachedQuestions.removeAt(index);
                            //     });
                            //   },
                            //   icon: const FaIcon(FontAwesomeIcons.xmark),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
