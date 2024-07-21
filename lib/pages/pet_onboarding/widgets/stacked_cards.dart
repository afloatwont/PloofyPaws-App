import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class StackOfCards extends StatelessWidget {
  final String? label;
  final String? imageAsset;
  final void Function()? onTap;

  const StackOfCards({
    super.key,
    this.label,
    this.imageAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = context
        .read<UrlProvider>()
        .urlMap['assets/images/placeholders/pet_type_placeholder.png'];
    final imageUrl = imageAsset != null
        ? context.read<UrlProvider>().urlMap[imageAsset]
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0.0, right: 64.0, left: 64.0),
            child: Card(
              color: Color(0xffBBBBBB),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 40.0, left: 40.0),
            child: Card(
              color: Color(0xff858585),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0, left: 16.0, top: 16, bottom: 16),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(placeholder!),
                  fit: BoxFit.fill,
                ),
                // borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          label ?? 'Pet Type',
                          style: typography(context)
                              .title1
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: imageUrl,
                                height: 180,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
