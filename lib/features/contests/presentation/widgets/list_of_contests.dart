import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/presentation/blocs/contest_bloc.dart';
import 'package:think_tank/features/contests/presentation/widgets/contest_card.dart';

class ListOfContests extends StatelessWidget {
  const ListOfContests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContestBloc, ContestState>(builder: (context, state) {
      List<Contest> contests = [];
      if (state is ContestLoaded && state.contests.isNotEmpty) {
        contests.addAll(state.contests);
        return _buildContestsList(contests: contests);
      } else if (state is ContestCreated) {
        contests.add(state.contest);
        return const Center(child: CircularProgressIndicator());
      } else if (state is ContestUpdated) {
        BlocProvider.of<ContestBloc>(context).add(const GetContestsEvent());
      }
      return Center(
        child: Text(
          'no_contests_found.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    });
  }

  Widget _buildContestsList({required List<Contest> contests}) {
    return ListView(
      children: contests.map((contest) {
        return ContestCard(contest: contest);
      }).toList(),
    );
  }
}
