import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/video_call/screens/meeting_controls.dart';
import 'package:ploofypaws/video_call/widgets/participant_tile.dart';
import 'package:videosdk/videosdk.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen(
      {super.key, required this.meetingId, required this.token});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late Room _room;
  var micEnabled = true;
  var camEnabled = true;

  Map<String, Participant> participants = {};

  @override
  void initState() {
    // create room
    _room = VideoSDK.createRoom(
        roomId: widget.meetingId,
        token: widget.token,
        displayName: "John Doe",
        micEnabled: micEnabled,
        camEnabled: camEnabled,
        defaultCameraIndex: kIsWeb
            ? 0
            : 1 // Index of MediaDevices will be used to set default camera
        );

    setMeetingEventListener();

    // Join room
    _room.join();

    super.initState();
  }

  // listening to meeting events
  void setMeetingEventListener() {
    _room.on(Events.roomJoined, () {
      setState(() {
        participants.putIfAbsent(
            _room.localParticipant.id, () => _room.localParticipant);
      });
    });

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(
          () => participants.putIfAbsent(participant.id, () => participant),
        );
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(
          () => participants.remove(participantId),
        );
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  // onbackButton pressed leave the room
  bool _onWillPop()  {
    _room.leave();
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _room.leave();
            Navigator.pop(context);
          },
        ),
        title: Text('Meeting'),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Display the meeting ID
            Text(
              widget.meetingId,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Render all participants
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 300,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: ParticipantTile(
                        key: Key(participants.values.elementAt(index).id),
                        participant: participants.values.elementAt(index),
                      ),
                    );
                  },
                  itemCount: participants.length,
                ),
              ),
            ),
            // Meeting controls
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(micEnabled ? Icons.mic : Icons.mic_off),
                    onPressed: () {
                      micEnabled ? _room.muteMic() : _room.unmuteMic();
                      setState(() {
                        micEnabled = !micEnabled;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(camEnabled ? Icons.videocam : Icons.videocam_off),
                    onPressed: () {
                      camEnabled ? _room.disableCam() : _room.enableCam();
                      setState(() {
                        camEnabled = !camEnabled;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.call_end, color: Colors.red),
                    onPressed: () {
                      _room.leave();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
