import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.url});
  final String url;
  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(
            () {}); // To refresh the widget after the video has initialized
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      color: Colors.transparent,
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: VideoPlayer(_controller)),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          }
        },
      ),
    );
  }
}
