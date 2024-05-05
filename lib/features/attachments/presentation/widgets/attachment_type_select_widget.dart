import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';

class AttachmentTypeSelectWidget extends StatefulWidget {
  final Function(List<AttachmentType>) onSelected;
  const AttachmentTypeSelectWidget({super.key, required this.onSelected});

  @override
  State<AttachmentTypeSelectWidget> createState() =>
      _AttachmentTypeSelectWidgetState();
}

class _AttachmentTypeSelectWidgetState
    extends State<AttachmentTypeSelectWidget> {
  List<AttachmentType> selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 8.0,
      children: [
        for (AttachmentType type in selectedTypes) _buildTypeChip(type: type),
        for (AttachmentType type in AttachmentType.values)
          if (!selectedTypes.contains(type))
            ActionChip(
              label: Text(type.toString().split('.').last.tr()),
              avatar: FaIcon(getIcon(type)),
              onPressed: () {
                setState(() {
                  selectedTypes.add(type);
                  widget.onSelected(selectedTypes);
                });
              },
            ),
      ],
    );
  }

  Widget _buildTypeChip({required AttachmentType type}) {
    return Chip(
      label: Text(type.toString().split('.').last.tr()),
      avatar: FaIcon(getIcon(type)),
      onDeleted: () {
        setState(() {
          selectedTypes.remove(type);
          widget.onSelected(selectedTypes);
        });
      },
    );
  }

  IconData getIcon(AttachmentType type) {
    switch (type) {
      case AttachmentType.image:
        return FontAwesomeIcons.image;
      case AttachmentType.video:
        return FontAwesomeIcons.video;
      case AttachmentType.audio:
        return FontAwesomeIcons.music;
      case AttachmentType.file:
        return FontAwesomeIcons.file;
      case AttachmentType.link:
        return FontAwesomeIcons.link;
      case AttachmentType.text:
        return FontAwesomeIcons.font;
      case AttachmentType.pdf:
        return FontAwesomeIcons.filePdf;
    }
  }
}
