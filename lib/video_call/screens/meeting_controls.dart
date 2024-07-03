import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MeetingControls extends StatelessWidget {
  final void Function() onToggleMicButtonPressed;
  final void Function() onToggleCameraButtonPressed;
  final void Function() onLeaveButtonPressed;

  const MeetingControls(
      {super.key,
      required this.onToggleMicButtonPressed,
      required this.onToggleCameraButtonPressed,
      required this.onLeaveButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.call_end, color: Colors.red),
          onPressed: onLeaveButtonPressed,
        ),
        IconButton(
          icon: const Icon(Icons.mic),
          onPressed: onToggleMicButtonPressed,
        ),
        IconButton(
          icon: const Icon(
            Icons.cameraswitch_outlined,
            color: Colors.black,
          ),
          onPressed: onToggleCameraButtonPressed,
        ),
      ],
    );
  }
}
