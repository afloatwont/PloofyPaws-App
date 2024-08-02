import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MapAnimation extends StatelessWidget {
  const MapAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white.withOpacity(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/content/pinMap.json'),
          const Text("Fetching your location"),
        ],
      ),
    );
  }
}
