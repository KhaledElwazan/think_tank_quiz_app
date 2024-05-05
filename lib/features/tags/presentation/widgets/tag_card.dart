import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';

class TagCard extends StatelessWidget {
  final Tag tag;
  const TagCard({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          tag.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Row(
          children: [
            tag.updatedAt != null
                ? Text(
                    DateFormat.MMMMEEEEd().format(tag.updatedAt!),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                : Text(
                    DateFormat.MMMMEEEEd().format(tag.createdAt),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
            const Spacer(),
            FaIcon(
              FontAwesomeIcons.tag,
              color: Color(tag.color),
            ),
          ],
        ),
      ),
    );
  }
}
