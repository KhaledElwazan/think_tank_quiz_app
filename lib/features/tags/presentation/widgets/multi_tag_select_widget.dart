import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';

class MultiTagSelectWidget extends StatefulWidget {
  // create onSelected callback
  final Function(List<Tag>) onSelected;
  const MultiTagSelectWidget({super.key, required this.onSelected});

  @override
  State<MultiTagSelectWidget> createState() => _MultiTagSelectWidgetState();
}

class _MultiTagSelectWidgetState extends State<MultiTagSelectWidget> {
  List<Tag> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        List<Tag> tags = [];

        if (state is TagsLoadedState) {
          tags.addAll(state.tags);
        }

        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          spacing: 8.0,
          children: [
            for (Tag tag in selectedTags) _buildTagChip(tag: tag),
            for (Tag tag in tags)
              if (!selectedTags.contains(tag))
                ActionChip(
                  avatar: CircleAvatar(
                    backgroundColor: Color(tag.color),
                  ),
                  label: Text(tag.title),
                  onPressed: () {
                    setState(() {
                      selectedTags.add(tag);
                      widget.onSelected(selectedTags);
                    });
                  },
                ),
          ],
        );
      },
    );
  }

  Widget _buildTagChip({required Tag tag}) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Color(tag.color),
      ),
      // padding: const EdgeInsets.all(2.0),
      label: Text(
        tag.title,
      ),
      onDeleted: () {
        setState(() {
          selectedTags.remove(tag);
          widget.onSelected(selectedTags);
        });
      },
    );
  }
}
