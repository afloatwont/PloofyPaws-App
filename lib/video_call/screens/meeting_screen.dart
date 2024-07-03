import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/video_call/screens/meeting_controls.dart';
import 'package:ploofypaws/video_call/widgets/participant_tile.dart';
import 'package:videosdk/videosdk.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;

  const MeetingScreen({Key? key, required this.meetingId, required this.token})
      : super(key: key);

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
      defaultCameraIndex: kIsWeb ? 0 : 1,
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
          _room.localParticipant.id,
          () => _room.localParticipant,
        );
      });
    });

    _room.on(
      Events.participantJoined,
      (Participant participant) {
        setState(
            () => participants.putIfAbsent(participant.id, () => participant));
      },
    );

    _room.on(Events.participantLeft, (String participantId) {
      if (participants.containsKey(participantId)) {
        setState(() => participants.remove(participantId));
      }
    });

    _room.on(Events.roomLeft, () {
      participants.clear();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Participant> otherParticipants = participants.values
        .where((participant) => participant.id != _room.localParticipant.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.meetingId),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return ParticipantTile(
                          key: Key(otherParticipants[index].id),
                          participant: otherParticipants[index],
                        );
                      },
                      itemCount: otherParticipants.length,
                    ),
                  ),
                  if (participants.isNotEmpty)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ParticipantTile(
                          key: Key(_room.localParticipant.id),
                          participant: _room.localParticipant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            MeetingControls(
              onToggleMicButtonPressed: () {
                micEnabled ? _room.muteMic() : _room.unmuteMic();
                setState(() {
                  micEnabled = !micEnabled;
                });
              },
              onToggleCameraButtonPressed: () {
                // camEnabled ? _room.changeCam() : _room.enableCam();
                setState(() {
                  camEnabled = !camEnabled;
                });
              },
              onLeaveButtonPressed: () {
                _room.leave();
              },
            ),
          ],
        ),
      ),
    );
  }
}
