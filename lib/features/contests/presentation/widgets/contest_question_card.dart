import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/widgets/image_thumbnail.dart';
import 'package:think_tank/features/questions/presentation/widgets/multi_choice_item.dart';
import 'package:think_tank/features/questions/presentation/widgets/video_thumbnail.dart';

class ContestQuestionCard extends StatefulWidget {
  final Question question;
  final int initialSelectedAnswerIndex;
  final void Function(int) onAnswered;
  const ContestQuestionCard({
    super.key,
    required this.question,
    required this.onAnswered,
    this.initialSelectedAnswerIndex = -1,
  });

  @override
  State<ContestQuestionCard> createState() => _ContestQuestionCardState();
}

class _ContestQuestionCardState extends State<ContestQuestionCard> {
  late Question question;
  List<String> questionChoices = [];

  @override
  void initState() {
    super.initState();
    question = widget.question;
    questionChoices = question.choices;
    selectedAnswerIndex = widget.initialSelectedAnswerIndex;
  }

  int selectedAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    setState(() {
      question = widget.question;
      selectedAnswerIndex = widget.initialSelectedAnswerIndex;
    });

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.users),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  List<int> randomIndices = [];
                  while (randomIndices.length < 2) {
                    int randomIndex = Random().nextInt(question.choices.length);
                    if (randomIndex != question.correctChoiceIndex &&
                        !randomIndices.contains(randomIndex)) {
                      randomIndices.add(randomIndex);
                    }
                  }

                  // remove those indices from the choices list
                  List<String> choices = [];
                  for (int i = 0; i < question.choices.length; i++) {
                    if (!randomIndices.contains(i)) {
                      choices.add(question.choices[i]);
                    }
                  }

                  // print(randomIndices);
                  setState(() {
                    questionChoices = choices;
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.diceTwo,
                ),
              ),
            ],
          ),
          Text(
            question.statement,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              width: constraints.maxWidth > 850 ? 800 : constraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Wrap(
                    children: List.generate(
                      question.choices.length,
                      (index) {
                        print(selectedAnswerIndex);
                        print(index);
                        return InkWell(
                          onTap: () => setState(() {
                            if (selectedAnswerIndex == -1) {
                              selectedAnswerIndex = index;
                              widget.onAnswered.call(index);
                            }
                          }),
                          child: MultiChoiceItem(
                            text: question.choices[index],
                            isSelected:
                                selectedAnswerIndex == index ? true : false,
                          ),
                        );
                      },
                    ),
                  ),
                  if (question.attachments.isNotEmpty) ...[
                    const SizedBox(height: 20 / 2),
                    const Divider(thickness: 1),
                    LayoutBuilder(
                      builder: (context, constraints) => SizedBox(
                        width: constraints.maxWidth > 850
                            ? 800
                            : constraints.maxWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (question.attachments.isNotEmpty) ...[
                              const SizedBox(height: 20 / 2),
                              Wrap(
                                children:
                                    question.attachments.map((attachment) {
                                  switch (attachment.type) {
                                    case AttachmentType.video:
                                      return VideoThumbnail(
                                          attachment: attachment);
                                    case AttachmentType.image:
                                      return ImageThumbnail(
                                          attachment: attachment);
                                    default:
                                      return Container();
                                  }
                                }).toList(),
                              )
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
