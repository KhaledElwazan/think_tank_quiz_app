import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/core/ui/pages/home_page/home_page.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/presentation/blocs/bloc/attachments_bloc.dart';
import 'package:think_tank/features/attachments/presentation/widgets/attachment_selector_modal_sheet.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/blocs/questions_bloc/questions_bloc.dart';
import 'package:think_tank/features/questions/presentation/widgets/image_thumbnail.dart';
import 'package:think_tank/features/questions/presentation/widgets/multi_choice_item.dart';
import 'package:think_tank/features/questions/presentation/widgets/video_thumbnail.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/widgets/select_tag_widget.dart';

class CreateQuestionPage extends StatefulWidget {
  static const routeName = '/create-question';
  final Question? question;
  const CreateQuestionPage({super.key, this.question});

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController statementController = TextEditingController();
  TextEditingController choiceController = TextEditingController();
  List<String> choices = [];
  List<Attachment> attachments = [];
  int selectedAnswer = -1;
  Tag? tag;

  final _createQuestionFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.question != null) {
      titleController.text = widget.question!.title;
      statementController.text = widget.question!.statement;
      choices = widget.question!.choices;
      selectedAnswer = widget.question!.correctChoiceIndex;
      tag = widget.question!.tag;
      attachments = widget.question!.attachments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create_question'.tr()),
        actions: [
          IconButton(
            onPressed: () async {
              return await showModalBottomSheet(
                context: context,
                builder: (context) => SelectTagModal(
                  onTagSelected: (tag) {
                    setState(() {
                      this.tag = tag;
                    });
                  },
                ),
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.tag,
              color: tag == null ? Colors.grey : Color(tag!.color),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_createQuestionFormKey.currentState!.validate()) {
            Question question = Question(
              title: titleController.text,
              statement: statementController.text,
              choices: choices,
              attachments: attachments,
              tag: tag,
              correctChoiceIndex: selectedAnswer,
            );

            if (widget.question != null) {
              question.id = widget.question!.id;
              question.createdAt = widget.question!.createdAt;
              question.update();
              BlocProvider.of<QuestionsBloc>(context)
                  .add(UpdateQuestionEvent(question: question));
            } else {
              BlocProvider.of<QuestionsBloc>(context)
                  .add(CreateQuestionEvent(question: question));
            }
            // Navigator.of(context).pop();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
          }
        },
        child: const Icon(Icons.save),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<QuestionsBloc, QuestionsState>(
            listenWhen: ((previous, current) =>
                current is UpdatedQuestionState ||
                current is CreatedQuestionState),
            listener: (context, state) {
              if (state is UpdatedQuestionState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('question_updated_successfully'.tr()),
                  ),
                );
              } else if (state is CreatedQuestionState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('question_created_successfully'.tr()),
                  ),
                );
              }
            },
            child: Form(
              key: _createQuestionFormKey,
              child: Column(
                children: [
                  Card(
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
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            controller: statementController,
                            decoration: InputDecoration(
                              label: Text("statement".tr()),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'choices'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            choiceController.clear();
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('enter_the_choice_keyword'.tr()),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: choiceController,
                                      decoration: InputDecoration(
                                        label: Text("choice".tr()),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            choices.add(choiceController.text);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        icon: const FaIcon(
                                            FontAwesomeIcons.check),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        ),
                      ],
                    ),
                  ),
                  if (choices.isNotEmpty)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // const SizedBox(height: 20),
                            ...List.generate(
                              choices.length,
                              (index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedAnswer = index;
                                  });
                                },
                                child: MultiChoiceItem(
                                  text: choices[index],
                                  isSelected: index == selectedAnswer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const Divider(thickness: 1),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'attachments'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            attachmentSelector(context);
                          },
                          icon: const FaIcon(FontAwesomeIcons.plus),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                  LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth > 850
                          ? 800
                          : constraints.maxWidth,
                      child: BlocBuilder<AttachmentsBloc, AttachmentsState>(
                        builder: (context, state) {
                          if (state is AttachmentAdded) {
                            attachments.add(state.attachment);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (attachments.isNotEmpty) ...[
                                const SizedBox(height: 20 / 2),
                                Wrap(
                                  children: attachments.map((attachment) {
                                    switch (attachment.type) {
                                      case AttachmentType.video:
                                        return VideoThumbnail(
                                          attachment: attachment,
                                        );
                                      case AttachmentType.image:
                                        return ImageThumbnail(
                                          attachment: attachment,
                                        );
                                      default:
                                        return Container();
                                    }
                                  }).toList(),
                                )
                              ],
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
