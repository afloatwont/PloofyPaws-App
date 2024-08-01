import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/pages/root/root.dart';

class AiAppBar extends StatelessWidget {
  final double appBarHeight;

  const AiAppBar({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    final backgroundUrl = urlProvider.urlMap['assets/images/content/ai_bg.png'];
    final avatarUrl =
        urlProvider.urlMap['assets/images/content/dog_with_coat.jpeg'];

    return Container(
      height: appBarHeight,
      // padding: EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundUrl != null)
            CachedNetworkImage(
              imageUrl: backgroundUrl,
              placeholder: (context, url) => const LinearProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: avatarUrl != null
                      ? CachedNetworkImageProvider(avatarUrl)
                      : null,
                  child: avatarUrl == null ? const Icon(Icons.person) : null,
                ),
                const SizedBox(height: 36),
                const Text(
                  "PloofyBot",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "A live chat interface that allows for seamless, natural communication and connection.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 15,
            child: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Color.fromARGB(86, 255, 255, 255),
                child: Icon(Icons.close),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Root(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
