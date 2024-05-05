import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:think_tank/features/attachments/domain/entities/attachment/attachment.dart';

class VideoViewerPage extends StatefulWidget {
  final Attachment attachment;
  const VideoViewerPage({super.key, required this.attachment});

  @override
  State<VideoViewerPage> createState() => _VideoViewerPageState();
}

class _VideoViewerPageState extends State<VideoViewerPage> {
  Player player = Player();
  late VideoController controller;

  @override
  void initState() {
    super.initState();

    player = Player();
    player.open(
      Media(widget.attachment.url),
      play: false,
    );
    controller = VideoController(
      player,
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          player.playOrPause();

          setState(() {
            isPlaying = !isPlaying;
          });
        },
        child: FaIcon(
          isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
        ),
      ),
      appBar: AppBar(
        title: Text(widget.attachment.name),
      ),
      body: Expanded(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9.0 / 16.0,
            // Use [Video] widget to display video output.
            child: Video(
              controller: controller,
              controls: MaterialVideoControls,
            ),
          ),
        ),
      ),
    );
  }
}
