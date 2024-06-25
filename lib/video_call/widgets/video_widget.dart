import 'dart:async';

import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key, required this.meetingId, required this.token});
  final String meetingId, token;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late Room _room;
  bool _isJoined = false;
  String? _error;
  List<Participant> _remoteParticipants = [];

  @override
  void initState() {
    super.initState();
    joinRoom();
  }

  Future<void> joinRoom() async {
    try {
      _room = await VideoSDK.createRoom(
        roomId: widget.meetingId,
        token: widget.token,
        displayName: "Test",
        micEnabled: true,
        camEnabled: true,
        maxResolution: 'hd',
        defaultCameraIndex: 1,
      );

      _room.on(
        Events.participantJoined,
        (Participant participant) {
          setState(() {
            _remoteParticipants.add(participant);
          });

          participant.on(
            Events.streamEnabled,
            (Stream stream) {
              setState(() {});
            },
          );
        },
      );

      _room.on(
        Events.participantLeft,
        (Participant participant) {
          setState(() {
            _remoteParticipants.remove(participant);
          });
        },
      );

      await _room.join();
      setState(() {
        _isJoined = true;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _room.leave();
    super.dispose();
  }

  Widget buildVideoView(Participant participant, bool isLocal) {
    final videoStream = participant.streams.values
        .firstWhere((stream) => stream.kind == 'video', );
    if (videoStream == null) {
      return Container(
        color: Colors.black,
        child: Center(child: Text('No video')),
      );
    }
    return RTCVideoView(videoStream.renderer!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isJoined && _remoteParticipants.isNotEmpty)
            Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: buildVideoView(_remoteParticipants.first, false),
              ),
            ),
          if (_isJoined)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 120,
                height: 160,
                child: buildVideoView(_room.localParticipant, true),
              ),
            ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.switch_camera),
                  onPressed: () {
                    // _room.localParticipant.switchCamera();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.call_end),
                  onPressed: () {
                    _room.leave();
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.mic_off),
                  onPressed: () {
                    _room.localParticipant.muteMic();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
