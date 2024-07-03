import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MeetingControls extends StatefulWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls(
      {super.key,
      required this.onToggleMicButtonPressed,
      required this.onToggleCameraButtonPressed,
      required this.onLeaveButtonPressed});

  @override
  _MeetingControlsState createState() => _MeetingControlsState();
}

class _MeetingControlsState extends State<MeetingControls> {
  bool isMicOn = true;

  void _toggleMic() {
    setState(() {
      isMicOn = !isMicOn;
    });
    widget.onToggleMicButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20.0,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade300,
          child: IconButton(
            icon: Icon(
              isMicOn ? Icons.mic : Icons.mic_off,
              color: Colors.black,
            ),
            onPressed: _toggleMic,
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.red,
          child: IconButton(
            icon: const Icon(Icons.call_end, color: Colors.white),
            onPressed: widget.onLeaveButtonPressed,
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade300,
          child: IconButton(
            icon: const Icon(
              Icons.cameraswitch_outlined,
              color: Colors.black,
            ),
            onPressed: widget.onToggleCameraButtonPressed,
          ),
        ),
      ],
    );
  }
}
