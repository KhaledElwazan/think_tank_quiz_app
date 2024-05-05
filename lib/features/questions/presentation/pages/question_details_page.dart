import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/presentation/pages/image_viewer_page.dart';
import 'package:think_tank/features/attachments/presentation/pages/video_viewer_page.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/pages/create_question_page.dart';
import 'package:think_tank/features/questions/presentation/widgets/image_thumbnail.dart';
import 'package:think_tank/features/questions/presentation/widgets/multi_choice_item.dart';

class QuestionDetailsPage extends StatefulWidget {
  final Question question;
  const QuestionDetailsPage({super.key, required this.question});

  @override
  State<QuestionDetailsPage> createState() => _QuestionDetailsPageState();
}

class _QuestionDetailsPageState extends State<QuestionDetailsPage> {
  bool isFavored = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return CreateQuestionPage(
                  question: widget.question,
                );
              },
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.penToSquare),
      ),
      appBar: AppBar(
        title: const Text('Question Details'),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidStar,
              color: isFavored ? Colors.yellow : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavored = !isFavored;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.question.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(widget.question.statement,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width:
                      constraints.maxWidth > 850 ? 800 : constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Wrap(
                        children: List.generate(
                          widget.question.choices.length,
                          (index) => MultiChoiceItem(
                            text: widget.question.choices[index],
                            isSelected:
                                index == widget.question.correctChoiceIndex,
                          ),
                        ),
                      ),
                      if (widget.question.attachments.isNotEmpty) ...[
                        const SizedBox(height: 20 / 2),
                        Wrap(
                          children:
                              widget.question.attachments.map((attachment) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) {
                                              if (attachment.type ==
                                                  AttachmentType.image) {
                                                return ImageViewerPage(
                                                  attachment: attachment,
                                                );
                                              } else {
                                                return VideoViewerPage(
                                                  attachment: attachment,
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      },
                                      child: thumbnailWidget(
                                          attachment: attachment),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget thumbnailWidget({required Attachment attachment}) {
    if (attachment.type == AttachmentType.image) {
      return ImageThumbnail(attachment: attachment);
    } else if (attachment.type == AttachmentType.video) {
      return const FaIcon(
        FontAwesomeIcons.video,
        size: 50,
      );
    } else {
      return const FaIcon(
        FontAwesomeIcons.file,
        size: 50,
      );
    }
  }
}
