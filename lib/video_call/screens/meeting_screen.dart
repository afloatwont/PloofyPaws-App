import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meeting_provider.dart';
import '../widgets/video_widget.dart';

class MeetingScreen extends StatelessWidget {
  // final String roomId;
  const MeetingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final meetingProvider = Provider.of<MeetingProvider>(context);
    final meeting = meetingProvider.currentMeeting;

    if (meeting == null) {
      return const Scaffold(
        body: Center(
          child: Text('No active meeting'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting ID: ${meeting.id}'),
      ),
      body: VideoWidget(meetingId: meeting.id, token: meeting.token),
    );
  }
}
