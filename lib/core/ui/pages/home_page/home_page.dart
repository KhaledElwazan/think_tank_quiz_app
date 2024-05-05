import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/core/ui/pages/home_page/widgets/side_menu.dart';
import 'package:think_tank/features/contests/presentation/pages/create_contest_page.dart';
import 'package:think_tank/features/contests/presentation/widgets/list_of_contests.dart';
import 'package:think_tank/features/questions/presentation/pages/create_question_page.dart';
import 'package:think_tank/features/questions/presentation/widgets/list_of_questions.dart';
import 'package:think_tank/features/tags/presentation/pages/create_tag_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int initialActiveIndex = 0;
  int activeIndex = initialActiveIndex;

  List<Widget> views = [
    const ListOfQuestions(),
    const ListOfContests(),
  ];

  final PageController _pageController = PageController(
    initialPage: initialActiveIndex,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Think Tank'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'create'.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.question),
                        title: Text(
                          'create_a_question'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                            CreateQuestionPage.routeName,
                          );
                        },
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.school),
                        title: Text('create_a_contest'.tr()),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                            CreateContestPage.routeName,
                          );
                        },
                      ),
                      ListTile(
                        leading: const FaIcon(FontAwesomeIcons.tag),
                        title: Text('create_a_tag'.tr()),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(
                            CreateTagPage.routeName,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.question),
            label: 'questions'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.school),
            label: 'contests'.tr(),
          ),
        ],
      ),
      body: PageView(
        pageSnapping: true,
        controller: _pageController,
        children: views,
        onPageChanged: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
    );
  }
}
