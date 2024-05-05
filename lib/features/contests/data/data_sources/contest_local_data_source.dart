import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:think_tank/features/contests/data/models/contest_model/contest_model.dart';

abstract class ContestsLocalDataSource {
  Future<List<ContestModel>> getContests();
  Future<Unit> cacheContests(List<ContestModel> contests);
}

const cachedContests = "CACHED_CONTESTS";

class ContestsLocalDataSourceImpl extends ContestsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ContestsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheContests(List<ContestModel> contests) async {
    final List<dynamic> contestsJson =
        contests.map((contest) => contest.toJson()).toList();
    await sharedPreferences.setStringList(cachedContests,
        contestsJson.map((contest) => json.encode(contest)).toList());
    return Future.value(unit);
  }

  @override
  Future<List<ContestModel>> getContests() {
    final List<String>? cachedContestsJson =
        sharedPreferences.getStringList(cachedContests);

    if (cachedContestsJson == null) {
      return Future.value([]);
    }

    final List<ContestModel> cachedContestsList = cachedContestsJson
        .map((contest) => ContestModel.fromJson(json.decode(contest)))
        .toList();

    return Future.value(cachedContestsList);
  }
}
