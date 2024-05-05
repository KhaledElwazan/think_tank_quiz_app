import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/core/ui/pages/home_page/widgets/side_menu_item.dart';
import 'package:think_tank/core/ui/pages/settings_page/settings_page.dart';
import 'package:think_tank/features/attachments/presentation/blocs/bloc/attachments_bloc.dart';
import 'package:think_tank/features/attachments/presentation/pages/attachments_page.dart';
import 'package:think_tank/features/questions/presentation/blocs/questions_bloc/questions_bloc.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:think_tank/features/tags/presentation/pages/tags_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<Tag> tags = [];
  int numberOfQuestions = 0;
  int numberOfAttachments = 0;
  int numberOfTags = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TagsBloc>(context).add(const GetTagsEvent());
    BlocProvider.of<QuestionsBloc>(context).add(const GetQuestionsEvent());
    BlocProvider.of<AttachmentsBloc>(context).add(const GetAttachmentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TagsBloc, TagsState>(
          listener: (context, state) {
            if (state is TagsLoadedState) {
              setState(() {
                tags = state.tags;
                numberOfTags = tags.length;
              });
            }
          },
        ),
        BlocListener<QuestionsBloc, QuestionsState>(
          listenWhen: (previous, current) => current is LoadedQuestionsState,
          listener: (context, state) {
            if (state is LoadedQuestionsState) {
              setState(() {
                numberOfQuestions = state.questions.length;
              });
            }
          },
        ),
        BlocListener<AttachmentsBloc, AttachmentsState>(
          listenWhen: (previous, current) => current is AttachmentsLoaded,
          listener: (context, state) {
            if (state is AttachmentsLoaded) {
              setState(() {
                numberOfAttachments = state.attachments.length;
              });
            }
          },
        ),
        BlocListener<TagsBloc, TagsState>(
          listenWhen: (previous, current) => current is TagsLoadedState,
          listener: (context, state) {
            if (state is TagsLoadedState) {
              setState(() {
                numberOfTags = state.tags.length;
              });
            }
          },
        ),
      ],
      child: Drawer(
        elevation: 10,
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.only(top: kIsWeb ? 20 : 0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20 / 2, horizontal: 20),
                            child: Container(
                              height: 300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Divider(thickness: 5, color: kWhiteColor),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'folders'.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  cardContainer(
                    widgets: [
                      SideMenuItem(
                        itemCount: numberOfQuestions,
                        title: 'all_questions'.tr(),
                        icon: FontAwesomeIcons.noteSticky,
                        press: () {},
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      SideMenuItem(
                        itemCount: 3,
                        title: 'all_favorites'.tr(),
                        icon: FontAwesomeIcons.star,
                        press: () {
                          //  TODO: Navigate to favorites page
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      SideMenuItem(
                        itemCount: numberOfTags,
                        title: 'tag_manager'.tr(),
                        icon: FontAwesomeIcons.userTag,
                        press: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(TagsViewerPage.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      SideMenuItem(
                        itemCount: numberOfAttachments,
                        title: 'attachments'.tr(),
                        icon: FontAwesomeIcons.paperclip,
                        press: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(AttachmentsPage.routeName);
                        },
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      SideMenuItem(
                        itemCount: 2,
                        title: 'recently_deleted'.tr(),
                        icon: FontAwesomeIcons.trashCan,
                        press: () {
                          //  TODO: Navigate to deleted page
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SideMenuItem(
                    itemCount: 0,
                    title: 'settings'.tr(),
                    icon: FontAwesomeIcons.gears,
                    press: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(SettingsPage.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardContainer({required List<Widget> widgets}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
