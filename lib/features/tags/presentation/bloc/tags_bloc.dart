import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/domain/usecases/create_tag.dart';
import 'package:think_tank/features/tags/domain/usecases/delete_tag.dart';
import 'package:think_tank/features/tags/domain/usecases/get_tags.dart';
import 'package:think_tank/features/tags/domain/usecases/update_tag.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final CreateTag createTag;
  final UpdateTag updateTag;
  final DeleteTag deleteTag;
  final GetTags getTags;

  TagsBloc({
    required this.createTag,
    required this.updateTag,
    required this.deleteTag,
    required this.getTags,
  }) : super(TagsInitial()) {
    on<TagsEvent>((event, emit) async {
      switch (event) {
        case GetTagsEvent():
          emit(const TagsLoadingState());
          final failureOrTags = await getTags();
          failureOrTags.fold(
              (failure) =>
                  emit(const TagsFailureState(message: 'Failed loading tags')),
              (tags) => emit(TagsLoadedState(tags: tags)));

        case CreateTagEvent():
          emit(const CreatingTagState());
          final failureOrCreate = await createTag(event.tag);
          failureOrCreate.fold(
              (failure) =>
                  emit(const TagsFailureState(message: 'Failed creating tag')),
              (created) => emit(TagCreatedState(tag: event.tag)));
        case UpdateTagEvent():
          emit(const UpdatingTagState());
          final failureOrUpdate = await updateTag(event.tag);
          failureOrUpdate.fold(
              (failure) =>
                  emit(const TagsFailureState(message: 'Failed updating tag')),
              (_) => emit(const TagUpdatedState()));
        case DeleteTagEvent():
          emit(const DeletingTagState());
          final failureOrDelete = await deleteTag(event.id);
          failureOrDelete.fold(
              (failure) =>
                  emit(const TagsFailureState(message: 'Failed deleting tag')),
              (_) => emit(const TagDeletedState()));
      }
    });
  }
}
