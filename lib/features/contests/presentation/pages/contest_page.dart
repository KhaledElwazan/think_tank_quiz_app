import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/presentation/pages/create_contest_page.dart';
import 'package:think_tank/features/contests/presentation/pages/run_contest_page.dart';
import 'package:think_tank/features/questions/presentation/widgets/question_card.dart';

class ContestPage extends StatelessWidget {
  final Contest contest;
  const ContestPage({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RunContestPage(
                contest: contest,
              ),
            ),
          );
        },
        child: const FaIcon(FontAwesomeIcons.play),
      ),
      appBar: AppBar(
        title: Text(contest.title),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.penToSquare),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateContestPage(
                    contest: contest,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                                contest.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (contest.description != null)
                                Text(contest.description!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    const SizedBox(width: 20),
                    ...contest.questions.map(
                      (question) => QuestionCard(question: question),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
