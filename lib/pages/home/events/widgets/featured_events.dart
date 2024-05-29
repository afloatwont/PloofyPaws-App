import 'package:flutter/material.dart';
import 'package:restoe/pages/home/events/widgets/event_card.dart';

class FeaturedEvents extends StatelessWidget {
  final List<PetEventItem> items;
  final PageController _controller = PageController(viewportFraction: 0.9);

  FeaturedEvents({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView.builder(
            controller: _controller,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double scale = 1.0;
                  if (_controller.position.haveDimensions) {
                    scale = _controller.page! - index;
                    scale = (1 - (scale.abs() * 0.2)).clamp(0.8, 1.0);
                  } else {
                    scale = index == 0 ? 1.0 : 0.8; // Default scale for the initial load
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeInOut.transform(scale) * MediaQuery.of(context).size.height * 0.5,
                      width: Curves.easeInOut.transform(scale) * MediaQuery.of(context).size.width * 1.8,
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(items[index].imageAsset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
