import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';


ImageProvider<Object> getAvatarImage(String? src) {
  if (src == null) {
    return const AssetImage('assets/images/placeholders/user_avatar.png');
  }

  return Image.network(
    src,
    loadingBuilder: (context, child, loadingProgress) => Image.asset('assets/images/placeholders/user_avatar_placeholder.png'),
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Image.asset('assets/images/placeholders/user_avatar.png');
    },
  ).image;
}

class UserAvatar extends StatelessWidget {
  final String? url;
  final double? radius;

  const UserAvatar({super.key, this.url, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: getAvatarImage(url),
    );
  }
}
