import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/pages/home/widgets/dot_background.dart';
import 'package:ploofypaws/pages/home/widgets/swipeable_cards/swiper.dart';

class EventStackedCards extends StatefulWidget {
  final VoidCallback onTap;
  final List<String> image;
  final Color? color1;
  final Color? color2;

  const EventStackedCards({
    super.key,
    required this.onTap,
    required this.image,
    this.color1,
    this.color2,
  });

  @override
  State<EventStackedCards> createState() => _EventStackedCardsState();
}

class _EventStackedCardsState extends State<EventStackedCards> {
  final AppinioSwiperController _swiperController = AppinioSwiperController();

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.watch<UrlProvider>();
    return Stack(
      children: [
        SizedBox(
          height: 450,
          width: double.infinity,
          child: CustomPaint(
            painter: FilledDotPainter(
                color: Colors.black12, dotSize: 2.0, gap: 15.0),
          ),
        ),
        Positioned.fill(
          child: SizedBox(
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: EventSwiper(
                controller: _swiperController,
                cardCount: widget.image.length,
                loop: true,
                backgroundCardOffset: const Offset(0, -25),
                backgroundCardCount: 2,
                cardBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: urlProvider.urlMap[widget.image[index]] != null ? DecorationImage(
                        image: CachedNetworkImageProvider(
                         urlProvider.urlMap[widget.image[index]]!   ,
                        ),
                        fit: BoxFit.cover,
                      ) : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
