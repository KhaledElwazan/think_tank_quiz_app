import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:think_tank/features/contests/domain/entities/contest.dart';
import 'package:think_tank/features/contests/presentation/pages/contest_page.dart';

class ContestCard extends StatelessWidget {
  final Contest contest;
  const ContestCard({super.key, required this.contest});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContestPage(contest: contest),
            ),
          );
        },
        title: Text(
          contest.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            contest.updatedAt != null
                ? Text(
                    DateFormat.MMMMEEEEd().format(contest.updatedAt!),
                  )
                : Text(
                    DateFormat.MMMMEEEEd().format(contest.createdAt),
                  ),
          ],
        ),
      ),
    );
  }
}
