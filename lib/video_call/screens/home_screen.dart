import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meeting_screen.dart';
import '../providers/meeting_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingProvider = Provider.of<MeetingProvider>(context);

    TextEditingController roomController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await meetingProvider.createMeeting();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeetingScreen(),
                  ),
                );
              },
              child: const Text('Start Meeting'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: roomController,
              decoration: const InputDecoration(
                hintText: 'Enter Room ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String roomId = roomController.text.trim();
                meetingProvider.currMeeting(roomId);
                if (roomId.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MeetingScreen(),
                    ),
                  );
                }
              },
              child: const Text('Join Room'),
            ),
          ],
        ),
      ),
    );
  }
}
