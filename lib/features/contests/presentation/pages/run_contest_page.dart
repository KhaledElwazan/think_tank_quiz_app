import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/presentation/widgets/contest_question_card.dart';

class RunContestPage extends StatefulWidget {
  final Contest contest;
  const RunContestPage({super.key, required this.contest});

  @override
  State<RunContestPage> createState() => _RunContestPageState();
}

class _RunContestPageState extends State<RunContestPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  int score = 0;
  int currentQuestionIndex = 0;

  late Contest contest;

  List<int> recordedAnswers = [];

  int finishedQuestions = 0;

  @override
  void initState() {
    super.initState();
    contest = widget.contest;
    recordedAnswers = List.filled(contest.questions.length, -1);
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$score/${contest.questions.length}'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.arrowLeft),
            label: 'previous',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.arrowRight),
            label: 'next',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            if (currentQuestionIndex > 0) {
              setState(() {
                currentQuestionIndex--;
              });
            }
          } else {
            if (currentQuestionIndex < contest.questions.length - 1) {
              setState(() {
                currentQuestionIndex++;
              });
            }
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: LinearProgressIndicator(
                      value:
                          (currentQuestionIndex + 1) / contest.questions.length,
                    ),
                  ),
                  if (finishedQuestions != contest.questions.length)
                    ContestQuestionCard(
                      question: contest.questions[currentQuestionIndex],
                      initialSelectedAnswerIndex:
                          recordedAnswers[currentQuestionIndex],
                      onAnswered: (index) {
                        setState(() {
                          score += index ==
                                  contest.questions[currentQuestionIndex]
                                      .correctChoiceIndex
                              ? 1
                              : 0;
                          recordedAnswers[currentQuestionIndex] = index;
                          finishedQuestions++;
                        });
                      },
                    ),
                  if (finishedQuestions == contest.questions.length)
                    playLottieAnimation(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget playLottieAnimation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Center(
          child: Lottie.network(
            'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
            repeat: false,
            animate: true,
            controller: _controller,
            frameRate: FrameRate.max,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
        ),
      ),
    );
  }
}
