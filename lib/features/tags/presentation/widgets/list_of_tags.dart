import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:think_tank/features/tags/presentation/widgets/tag_card.dart';

class ListOfTags extends StatelessWidget {
  const ListOfTags({super.key});

  @override
  Widget build(BuildContext context) {
    List<Tag> tags = [];
    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        if (state is TagsLoadedState) {
          tags.addAll(state.tags);
        } else if (state is TagsFailureState) {
          return const Center(
            child: Text('Error loading tags'),
          );
        } else if (state is TagCreatedState) {
          tags.add(state.tag);
        }

        if (tags.isEmpty) {
          return noTagsFound(context);
        }

        return ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, index) => TagCard(
            tag: tags[index],
          ),
        );
      },
    );
  }

  Widget noTagsFound(BuildContext context) {
    return Center(
      child: Text(
        'no_tags_found',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
