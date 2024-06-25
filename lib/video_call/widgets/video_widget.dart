// NOT A PART OF MAIN CODE
// USED FOR TESTING

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

  Widget buildVideoPlaceholder(bool isLocal) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLocal ? Colors.green : Colors.blue,
          width: 3,
        ),
        color: Colors.black.withOpacity(0.7),
      ),
      child: Center(
        child: Text(
          isLocal ? 'Local User' : 'Remote Participant',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
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
                child: buildVideoPlaceholder(false),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.77,
              width: MediaQuery.sizeOf(context).width * 0.95,
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: const Color.fromARGB(93, 255, 193, 7),
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(child: Text("Remote User")),
            ),
          ),
          if (_isJoined)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 120,
                height: 160,
                child: buildVideoPlaceholder(true),
              ),
            ),
          // Positioned(
          //   bottom: 20,
          //   left: 0,
          //   right: 0,
          // ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(color: Colors.black, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.switch_camera_outlined,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                // _room.localParticipant.switchCamera();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.call_end_outlined,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                _room.leave();
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.mic_off_outlined,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                _room.localParticipant.muteMic();
              },
            ),
          ],
        ),
      ),
    );
  }
}
