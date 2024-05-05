import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';

class ImageViewerPage extends StatelessWidget {
  final Attachment attachment;
  const ImageViewerPage({super.key, required this.attachment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attachment.name),
      ),
      body: PhotoView(
        imageProvider: FileImage(File(attachment.url)),
        enableRotation: true,
        minScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
