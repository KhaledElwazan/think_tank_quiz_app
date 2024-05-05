import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/presentation/blocs/bloc/attachments_bloc.dart';
import 'package:think_tank/features/attachments/presentation/widgets/attachment_card.dart';
import 'package:think_tank/features/attachments/presentation/widgets/attachment_type_select_widget.dart';

class ListOfAttachments extends StatefulWidget {
  const ListOfAttachments({super.key});

  @override
  State<ListOfAttachments> createState() => _ListOfAttachmentsState();
}

class _ListOfAttachmentsState extends State<ListOfAttachments> {
  double height = 0;
  List<AttachmentType> filters = [];

  @override
  Widget build(BuildContext context) {
    List<Attachment> attachments = [];
    return BlocBuilder<AttachmentsBloc, AttachmentsState>(
      builder: (context, state) {
        if (state is AttachmentsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AttachmentsLoaded) {
          attachments.addAll(state.attachments);
        } else if (state is AttachmentsError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is AttachmentAdded) {
          attachments.add(state.attachment);
        }

        if (attachments.isEmpty) {
          return noAttachmentFound(context);
        }

        List<Attachment> filteredAttachments = attachments;

        if (filters.isNotEmpty) {
          filteredAttachments = attachments
              .where((element) => filters.contains(element.type))
              .toList();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  height = height == 0 ? 100 : 0;
                });
              },
              icon: const FaIcon(FontAwesomeIcons.filter),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                height: height,
                width: double.infinity,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: height == 0 ? 0 : 1,
                  child: Visibility(
                    visible: height != 0,
                    child: AttachmentTypeSelectWidget(onSelected: (tags) {
                      setState(() {
                        filters = tags;
                      });
                    }),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAttachments.length,
                itemBuilder: (context, index) => AttachmentCard(
                  attachment: attachments[index],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget noAttachmentFound(BuildContext context) {
    return Center(
      child: Text(
        'no_attachments_found'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
