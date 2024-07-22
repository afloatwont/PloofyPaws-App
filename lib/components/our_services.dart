
import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key, required this.titles});
    // List of titles
  final List<String> titles;

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
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              return _buildServiceItem(titles[index], itemWidth, itemHeight);
            },
          );
        },
      ),
    );
  }



  Widget _buildServiceItem(String title, double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * 0.5,
          width: width * 0.5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}