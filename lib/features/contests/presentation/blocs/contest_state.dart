part of 'contest_bloc.dart';

sealed class ContestState extends Equatable {
  const ContestState();

  @override
  List<Object> get props => [];
}

final class ContestInitial extends ContestState {}

final class ContestLoading extends ContestState {}

final class ContestLoaded extends ContestState {
  final List<Contest> contests;

  const ContestLoaded(this.contests);

  @override
  List<Object> get props => [contests];
}

final class ContestError extends ContestState {
  final String message;

  const ContestError(this.message);

  @override
  List<Object> get props => [message];
}

final class ContestCreated extends ContestState {
  final Contest contest;

  const ContestCreated({required this.contest});

  @override
  List<Object> get props => [contest];
}

final class ContestUpdated extends ContestState {
  const ContestUpdated();

  @override
  List<Object> get props => [];
}

final class ContestDeleted extends ContestState {
  const ContestDeleted();

  @override
  List<Object> get props => [];
}
