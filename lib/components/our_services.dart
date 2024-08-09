import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({
    super.key,
    required this.titles,
    required this.images,
  });

  // List of titles
  final List<String> titles;

  // List of image paths or URLs
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the size for each item based on the available width
          double itemWidth = (constraints.maxWidth - 24.0) / 3;
          double itemHeight = itemWidth;

          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: titles.length, // Use the length of titles or images list
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return _buildServiceItem(
                titles[index],
                itemWidth,
                itemHeight,
                images[index], // Pass the image address for each item
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildServiceItem(
    String title,
    double width,
    double height,
    String image,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height * 0.5,
          width: width * 0.5,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(image), // Use NetworkImage for remote images
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
