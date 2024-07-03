import 'dart:ui';
import 'package:flutter/material.dart';

class AiAppBar extends StatelessWidget {
  final double appBarHeight;

  const AiAppBar({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: appBarHeight,
      expandedHeight: appBarHeight,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: const SizedBox(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/content/ai_bg.png', // Replace with your image asset path
              fit: BoxFit.fill,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 15),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ],
        ),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage(
                "assets/images/content/dog_with_coat.jpeg",
              ),
            ),
            SizedBox(height: 36),
            Text("PloofyBot",
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: Colors.white)),
            SizedBox(height: 16),
            Text(
              "A live chat interface that allows for seamless, natural communication and connection.",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
      ),
      actions: [
        IconButton(
          icon: const CircleAvatar(
            backgroundColor: Color.fromARGB(86, 255, 255, 255),
            child: Icon(Icons.close),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      pinned: true,
      backgroundColor: Colors.white,
    );
  }
}
