import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/domain/usecases/create_contest.dart';
import 'package:think_tank/features/contests/domain/usecases/delete_contest.dart';
import 'package:think_tank/features/contests/domain/usecases/get_all_contests.dart';
import 'package:think_tank/features/contests/domain/usecases/update_contest.dart';

part 'contest_event.dart';
part 'contest_state.dart';

class ContestBloc extends Bloc<ContestEvent, ContestState> {
  final GetAllContests getAllContests;
  final CreateContest createContest;
  final UpdateContest updateContest;
  final DeleteContest deleteContest;

  ContestBloc({
    required this.getAllContests,
    required this.createContest,
    required this.updateContest,
    required this.deleteContest,
  }) : super(ContestInitial()) {
    on<ContestEvent>(
      (event, emit) async {
        if (event is GetContestsEvent) {
          emit(ContestLoading());
          final failureOrContests = await getAllContests();
          failureOrContests.fold(
            (failure) => emit(const ContestError('Error fetching contests')),
            (contests) => emit(ContestLoaded(contests)),
          );
        } else if (event is CreateContestEvent) {
          emit(ContestLoading());
          final failureOrContest = await createContest(event.contest);
          failureOrContest.fold(
            (failure) => emit(const ContestError('Error creating contest')),
            (unit) => emit(ContestCreated(contest: event.contest)),
          );
        } else if (event is UpdateContestEvent) {
          emit(ContestLoading());
          final failureOrContest = await updateContest(event.contest);
          failureOrContest.fold(
            (failure) => emit(const ContestError('Error updating contest')),
            (contest) => emit(const ContestUpdated()),
          );
        } else if (event is DeleteContestEvent) {
          emit(ContestLoading());
          final failureOrContest = await deleteContest(event.id);
          failureOrContest.fold(
            (failure) => emit(const ContestError('Error deleting contest')),
            (unit) => emit(const ContestDeleted()),
          );
        }
      },
    );
  }
}
