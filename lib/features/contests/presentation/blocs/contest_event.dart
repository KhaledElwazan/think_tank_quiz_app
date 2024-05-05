part of 'contest_bloc.dart';

sealed class ContestEvent extends Equatable {
  const ContestEvent();

  @override
  List<Object> get props => [];
}

class GetContestsEvent extends ContestEvent {
  const GetContestsEvent();
}

class CreateContestEvent extends ContestEvent {
  final Contest contest;

  const CreateContestEvent({required this.contest});

  @override
  List<Object> get props => [contest];
}

class UpdateContestEvent extends ContestEvent {
  final Contest contest;

  const UpdateContestEvent({required this.contest});

  @override
  List<Object> get props => [contest];
}

class DeleteContestEvent extends ContestEvent {
  final String id;

  const DeleteContestEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetContestEvent extends ContestEvent {
  final String id;

  const GetContestEvent(this.id);

  @override
  List<Object> get props => [id];
}
