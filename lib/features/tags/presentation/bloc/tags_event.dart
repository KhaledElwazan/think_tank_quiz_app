part of 'tags_bloc.dart';

sealed class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

final class GetTagsEvent extends TagsEvent {
  const GetTagsEvent();

  @override
  List<Object> get props => [];
}

final class CreateTagEvent extends TagsEvent {
  final Tag tag;

  const CreateTagEvent({required this.tag});

  @override
  List<Object> get props => [tag];
}

final class UpdateTagEvent extends TagsEvent {
  final Tag tag;

  const UpdateTagEvent({required this.tag});

  @override
  List<Object> get props => [tag];
}

final class DeleteTagEvent extends TagsEvent {
  final String id;

  const DeleteTagEvent({required this.id});

  @override
  List<Object> get props => [id];
}
