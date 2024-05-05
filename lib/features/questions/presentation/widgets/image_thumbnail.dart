import 'dart:io';

import 'package:flutter/material.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';
import 'package:think_tank/features/attachments/presentation/pages/image_viewer_page.dart';

class ImageThumbnail extends StatelessWidget {
  final Attachment attachment;
  const ImageThumbnail({super.key, required this.attachment});

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
                    builder: (_) => ImageViewerPage(
                      attachment: attachment,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: attachment.isLocal
                    ? Image.file(
                        File(attachment.url),
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        attachment.url,
                        fit: BoxFit.cover,
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
