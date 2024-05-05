import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/presentation/pages/video_viewer_page.dart';

class VideoThumbnail extends StatelessWidget {
  final Attachment attachment;
  const VideoThumbnail({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: 100,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VideoViewerPage(
                      attachment: attachment,
                    ),
                  ),
                );
              },
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const FaIcon(
                    FontAwesomeIcons.video,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 100,
            child: Text(
              attachment.name,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
