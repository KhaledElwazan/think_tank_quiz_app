part of 'tags_bloc.dart';

sealed class TagsState extends Equatable {
  const TagsState();

  @override
  List<Object> get props => [];
}

final class TagsInitial extends TagsState {}

final class TagsLoadingState extends TagsState {
  const TagsLoadingState();

  @override
  List<Object> get props => [];
}

final class TagsLoadedState extends TagsState {
  final List<Tag> tags;

  const TagsLoadedState({required this.tags});

  @override
  List<Object> get props => [tags];
}

final class TagsFailureState extends TagsState {
  final String message;

  const TagsFailureState({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreatingTagState extends TagsState {
  const CreatingTagState();

  @override
  List<Object> get props => [];
}

final class TagCreatedState extends TagsState {
  final Tag tag;
  const TagCreatedState({required this.tag});

  @override
  List<Object> get props => [];
}

final class UpdatingTagState extends TagsState {
  const UpdatingTagState();

  @override
  List<Object> get props => [];
}

final class TagUpdatedState extends TagsState {
  const TagUpdatedState();

  @override
  List<Object> get props => [];
}

final class DeletingTagState extends TagsState {
  const DeletingTagState();

  @override
  List<Object> get props => [];
}

final class TagDeletedState extends TagsState {
  const TagDeletedState();

  @override
  List<Object> get props => [];
}

// final class TagErrorState extends TagsState {
//   final String message;

//   const TagErrorState({required this.message});

//   @override
//   List<Object> get props => [message];
// }
