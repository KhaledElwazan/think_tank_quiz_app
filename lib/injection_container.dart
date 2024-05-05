import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/features/attachments/data/data_sources/attachments_local_data_source.dart';
import 'package:think_tank/features/attachments/data/repositories/attachments_repository_impl.dart';
import 'package:think_tank/features/attachments/domain/repositories/attachment_repository.dart';
import 'package:think_tank/features/attachments/domain/usecases/create_attachment.dart';
import 'package:think_tank/features/attachments/domain/usecases/delete_attachment.dart';
import 'package:think_tank/features/attachments/domain/usecases/get_attachments.dart';
import 'package:think_tank/features/attachments/domain/usecases/update_attachment.dart';
import 'package:think_tank/features/attachments/presentation/blocs/bloc/attachments_bloc.dart';
import 'package:think_tank/features/contests/data/data_sources/contest_local_data_source.dart';
import 'package:think_tank/features/contests/data/repositories/contest_repository_impl.dart';
import 'package:think_tank/features/contests/domain/repositories/contests_repository.dart';
import 'package:think_tank/features/contests/domain/usecases/create_contest.dart';
import 'package:think_tank/features/contests/domain/usecases/delete_contest.dart';
import 'package:think_tank/features/contests/domain/usecases/get_all_contests.dart';
import 'package:think_tank/features/contests/domain/usecases/update_contest.dart';
import 'package:think_tank/features/contests/presentation/blocs/contest_bloc.dart';
import 'package:think_tank/features/questions/data/data_sources/questions_local_data_source.dart';
import 'package:think_tank/features/questions/data/repositories/questions_repository_impl.dart';
import 'package:think_tank/features/questions/domain/repositories/questions_repository.dart';
import 'package:think_tank/features/questions/domain/usecases/create_question.dart';
import 'package:think_tank/features/questions/domain/usecases/delete_question.dart';
import 'package:think_tank/features/questions/domain/usecases/get_questions.dart';
import 'package:think_tank/features/questions/domain/usecases/update_question.dart';
import 'package:think_tank/features/questions/presentation/blocs/questions_bloc/questions_bloc.dart';
import 'package:think_tank/features/tags/data/data_sources/tags_local_data_source.dart';
import 'package:think_tank/features/tags/data/repositories/tags_repository_impl.dart';
import 'package:think_tank/features/tags/domain/repositories/tags_repository.dart';
import 'package:think_tank/features/tags/domain/usecases/create_tag.dart';
import 'package:think_tank/features/tags/domain/usecases/delete_tag.dart';
import 'package:think_tank/features/tags/domain/usecases/get_tags.dart';
import 'package:think_tank/features/tags/domain/usecases/update_tag.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // blocs
  sl.registerFactory(() => QuestionsBloc(
        getQuestions: sl(),
        updateQuestion: sl(),
        deleteQuestion: sl(),
        createQuestion: sl(),
      ));

  sl.registerFactory<TagsBloc>(() => TagsBloc(
        createTag: sl(),
        updateTag: sl(),
        deleteTag: sl(),
        getTags: sl(),
      ));
  sl.registerFactory<AttachmentsBloc>(() => AttachmentsBloc(
        attachmentsRepository: sl(),
      ));

  sl.registerFactory<ContestBloc>(
    () => ContestBloc(
        getAllContests: sl(),
        createContest: sl(),
        updateContest: sl(),
        deleteContest: sl()),
  );

  // Use cases

  sl.registerLazySingleton(
    () => CreateQuestion(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UpdateQuestion(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DeleteQuestion(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetQuestions(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<CreateTag>(() => CreateTag(
        tagsRepository: sl(),
      ));

  sl.registerLazySingleton<UpdateTag>(() => UpdateTag(
        tagsRepository: sl(),
      ));

  sl.registerLazySingleton<DeleteTag>(() => DeleteTag(
        tagsRepository: sl(),
      ));

  sl.registerLazySingleton<GetTags>(() => GetTags(
        tagsRepository: sl(),
      ));

  sl.registerLazySingleton<CreateAttachment>(() => CreateAttachment(
        attachmentsRepository: sl(),
      ));

  sl.registerLazySingleton<UpdateAttachment>(() => UpdateAttachment(
        attachmentRepository: sl(),
      ));

  sl.registerLazySingleton<GetAttachments>(() => GetAttachments(
        attachmentsRepository: sl(),
      ));

  sl.registerLazySingleton<DeleteAttachment>(() => DeleteAttachment(
        attachmentsRepository: sl(),
      ));

  sl.registerLazySingleton<GetAllContests>(() => GetAllContests(
        contestRepository: sl(),
      ));

  sl.registerLazySingleton<CreateContest>(() => CreateContest(
        contestsRepository: sl(),
      ));

  sl.registerLazySingleton<UpdateContest>(() => UpdateContest(
        contestRepository: sl(),
      ));

  sl.registerLazySingleton<DeleteContest>(() => DeleteContest(
        contestRepository: sl(),
      ));

  // Repositories
  sl.registerLazySingleton<QuestionsRepository>(() => QuestionsRepositoryImpl(
        questionsLocalDataSource: sl(),
      ));

  sl.registerLazySingleton<TagsRepository>(() => TagsRepositoryImpl(
        tagsLocalDataSource: sl(),
      ));

  sl.registerLazySingleton<AttachmentsRepository>(
      () => AttachmentsRepositoryImpl(
            attachmentsLocalDataSource: sl(),
          ));

  sl.registerLazySingleton<ContestsRepository>(() => ContestsRepositoryImpl(
        contestsLocalDataSource: sl(),
      ));

  // Data sources

  sl.registerLazySingleton<QuestionsLocalDataSource>(
    () => QuestionsLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton<TagsLocalDataSource>(() => TagsLocalDataSourceImpl(
        sharedPreferences: sl(),
      ));

  sl.registerLazySingleton<AttachmentsLocalDataSource>(
      () => AttachmentsLocalDataSourceImpl(
            sharedPreferences: sl(),
          ));

  sl.registerLazySingleton<ContestsLocalDataSource>(
      () => ContestsLocalDataSourceImpl(
            sharedPreferences: sl(),
          ));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
