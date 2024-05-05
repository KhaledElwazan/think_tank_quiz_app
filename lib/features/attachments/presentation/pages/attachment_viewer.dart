// import 'package:edu_smart/models/attachment/attachment.dart';
// import 'package:edu_smart/ui/screens/attachment_viewer/pdf_attachment_viewer.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:photo_view/photo_view.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';

class AttachmentViewer extends StatefulWidget {
  final Attachment attachment;
  final bool isLocalFile;
  const AttachmentViewer({
    super.key,
    required this.attachment,
    this.isLocalFile = false,
  });

  @override
  State<AttachmentViewer> createState() => _AttachmentViewerState();
}

class _AttachmentViewerState extends State<AttachmentViewer> {
  @override
  void initState() {
    super.initState();
    player.open(Media(widget.attachment.url));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // if (widget.attachment == null) {
    //   return Container(
    //     color: Colors.white,
    //   );
    // }

    // if (widget.attachment!.type == AttachmentType.) {
    //   return PDFAttachmentViewer(attachment: widget.attachment);
    // }

    var image = widget.isLocalFile
        ? Image.file(File(widget.attachment.url)).image
        : Image.network(widget.attachment.url).image;

    return Scaffold(
      // // backgroundColor: Colors.red,
      // appBar: AppBar(
      //   title: Text(widget.attachment.name),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButton(
                        style: ButtonStyle(
                            iconSize: MaterialStateProperty.all(40)),
                      ),
                      // const Spacer(),
                      SizedBox(
                        width: size.width * 0.75,
                        child: Text(
                          widget.attachment.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1),
                if (widget.attachment.type == AttachmentType.image)
                  // Image.network(widget.attachment.url),
                  SizedBox(
                    height: size.height * 0.75,
                    width: size.width,
                    child: PhotoView(
                      imageProvider: image,
                      backgroundDecoration: const BoxDecoration(
                          //     // color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                if (widget.attachment.type == AttachmentType.video)
                  showVideoPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showPDF() {
    return const Scaffold();
  }

  late final player = Player();
  late final controller = VideoController(player);
  Widget showVideoPlayer() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        // Use [Video] widget to display video output.
        child: Video(controller: controller),
      ),
    );
  }
}
