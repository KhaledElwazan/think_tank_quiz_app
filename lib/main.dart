import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:think_tank/core/ui/pages/home_page/home_page.dart';
import 'package:think_tank/core/ui/pages/settings_page/settings_page.dart';
import 'package:think_tank/features/attachments/presentation/blocs/bloc/attachments_bloc.dart';
import 'package:think_tank/features/attachments/presentation/pages/attachments_page.dart';
import 'package:think_tank/features/attachments/presentation/pages/create_attachment_page.dart';
import 'package:think_tank/features/contests/presentation/blocs/contest_bloc.dart';
import 'package:think_tank/features/contests/presentation/pages/create_contest_page.dart';
import 'package:think_tank/features/questions/presentation/blocs/questions_bloc/questions_bloc.dart';
import 'package:think_tank/features/questions/presentation/pages/create_question_page.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:think_tank/features/tags/presentation/pages/create_tag_page.dart';
import 'package:think_tank/features/tags/presentation/pages/tags_page.dart';
import 'injection_container.dart' as di;

import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MediaKit.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TagsBloc>(
          create: (context) => TagsBloc(
            createTag: di.sl(),
            updateTag: di.sl(),
            deleteTag: di.sl(),
            getTags: di.sl(),
          )..add(const GetTagsEvent()),
        ),
        BlocProvider<AttachmentsBloc>(
          create: (context) => AttachmentsBloc(
            attachmentsRepository: di.sl(),
          )..add(
              const GetAttachmentsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => QuestionsBloc(
            getQuestions: di.sl(),
            updateQuestion: di.sl(),
            deleteQuestion: di.sl(),
            createQuestion: di.sl(),
          )..add(
              const GetQuestionsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => ContestBloc(
            getAllContests: di.sl(),
            createContest: di.sl(),
            updateContest: di.sl(),
            deleteContest: di.sl(),
          )..add(
              const GetContestsEvent(),
            ),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
          Locale('ja'),
          Locale('de'),
          Locale('he'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'USA'),
        saveLocale: true,
        useOnlyLangCode: true,
        child: const AppRoot(),
      ),
    ),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    // get the theme from the AdaptiveTheme
    // var theme = AdaptiveTheme.of(context).mode;
    // print(theme);
    return AdaptiveTheme(
      debugShowFloatingThemeButton: false,
      initial: AdaptiveThemeMode.system,
      light: FlexThemeData.light(scheme: FlexScheme.green, useMaterial3: true),
      dark: FlexThemeData.dark(scheme: FlexScheme.green, useMaterial3: true),
      builder: (theme, darkTheme) => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          CreateQuestionPage.routeName: (context) => const CreateQuestionPage(),
          HomePage.routeName: (context) => const HomePage(),
          AttachmentsPage.routeName: (context) => const AttachmentsPage(),
          CreateAttachmentPage.routeName: (context) =>
              const CreateAttachmentPage(),
          CreateTagPage.routeName: (context) => const CreateTagPage(),
          TagsViewerPage.routeName: (context) => const TagsViewerPage(),
          CreateContestPage.routeName: (context) => const CreateContestPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
