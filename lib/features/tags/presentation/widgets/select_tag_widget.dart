import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:think_tank/features/tags/presentation/pages/create_tag_page.dart';

class SelectTagModal extends StatefulWidget {
  final Function(Tag)? onTagSelected;
  const SelectTagModal({
    super.key,
    this.onTagSelected,
  });

  @override
  State<SelectTagModal> createState() => _SelectTagModalState();
}

class _SelectTagModalState extends State<SelectTagModal> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TagsBloc>(context).add(const GetTagsEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: BlocBuilder<TagsBloc, TagsState>(
            builder: (context, state) {
              List<Tag> tags = [];
              if (state is TagsLoadingState) {
                return loading(context);
              } else if (state is TagsLoadedState) {
                tags = state.tags;
              } else if (state is TagsFailureState) {
                return noTagsFound(context);
              } else if (state is TagCreatedState) {
                BlocProvider.of<TagsBloc>(context).add(const GetTagsEvent());
              }

              if (tags.isEmpty) {
                return noTagsFound(context);
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'select_tag'.tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(CreateTagPage.routeName);
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      children: tags
                          .map(
                            (tag) => GestureDetector(
                              onTap: () {
                                if (widget.onTagSelected != null) {
                                  widget.onTagSelected!(tag);
                                }
                                Navigator.of(context).pop(tag);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      color: Color(tag.color),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const SizedBox(
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    Text(
                                      tag.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget loading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
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

  // int to hex
  String intToHex(int color) {
    return color.toRadixString(16).padLeft(6, '0').toUpperCase();
  }
}
