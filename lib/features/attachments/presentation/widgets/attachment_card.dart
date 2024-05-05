import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/presentation/pages/image_viewer_page.dart';
import 'package:think_tank/features/attachments/presentation/pages/video_viewer_page.dart';

class AttachmentCard extends StatelessWidget {
  final Attachment attachment;
  const AttachmentCard({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        onTap: () {
          if (attachment.type == AttachmentType.image) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ImageViewerPage(
                  attachment: attachment,
                ),
              ),
            );
          } else if (attachment.type == AttachmentType.video) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => VideoViewerPage(
                  attachment: attachment,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('feature_not_supported_yet'),
              ),
            );
          }
        },
        title: Text(
          attachment.name,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            attachment.updatedAt != null
                ? Text(
                    DateFormat.MMMMEEEEd().format(attachment.updatedAt!),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                : Text(
                    DateFormat.MMMMEEEEd().format(attachment.createdAt),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
            const Spacer(),
            FaIcon(
              attachmentType2Icon(attachment.type),
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  IconData attachmentType2Icon(AttachmentType attachmentType) {
    switch (attachmentType) {
      case AttachmentType.audio:
        return FontAwesomeIcons.microphone;
      case AttachmentType.video:
        return FontAwesomeIcons.video;
      case AttachmentType.image:
        return FontAwesomeIcons.image;
      case AttachmentType.text:
        return FontAwesomeIcons.fileLines;
      default:
        return FontAwesomeIcons.file;
    }
  }
}
