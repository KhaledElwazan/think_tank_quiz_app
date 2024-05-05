import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:think_tank/features/questions/domain/entities/question/question.dart';
import 'package:think_tank/features/questions/presentation/pages/question_details_page.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';

class QuestionCard extends StatefulWidget {
  final Question question;
  final bool editingMode;
  const QuestionCard({
    super.key,
    required this.question,
    this.editingMode = true,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late Question question;

  @override
  void initState() {
    super.initState();
    question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      question = widget.question;
    });

    Tag? tag = widget.question.tag;

    // get primary color
    Color primaryColor = Theme.of(context).primaryColor;

    Color tagColor = Color(tag?.color ?? primaryColor.value);

    tagColor = tagColor.withOpacity(0.1);

    bool isFavored = true;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QuestionDetailsPage(
                question: widget.question,
              ),
            ),
          );
        },
        title: Text(
          widget.question.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Row(
          children: [
            widget.question.updatedAt != null
                ? Text(
                    DateFormat.MMMMEEEEd().format(
                      widget.question.updatedAt!,
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                : Text(
                    DateFormat.MMMMEEEEd().format(
                      widget.question.createdAt,
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
            if (question.attachments.isNotEmpty)
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text('|'),
                  SizedBox(width: 10),
                  FaIcon(
                    FontAwesomeIcons.paperclip,
                    size: 15,
                  ),
                ],
              ),
            if (isFavored)
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text('|'),
                  SizedBox(width: 10),
                  FaIcon(
                    Icons.star,
                    size: 20,
                    color: Colors.yellow,
                  ),
                ],
              ),
          ],
        ),
        trailing: widget.question.tag != null
            ? FaIcon(
                FontAwesomeIcons.tag,
                color: Color(question.tag!.color),
              )
            : null,
      ),
    );
  }
}
