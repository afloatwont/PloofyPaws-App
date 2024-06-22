import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title, link;
  final Color? color;
  const CategoryCard(
      {super.key,
      required this.title,
      required this.link,
      required this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width / 2 - 32,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
          Image.network(
            link,
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }
}

const card = CategoryCard(
  title: "Text",
  link:
      "https://p7.hiclipart.com/preview/179/880/857/apple-watch-series-3-apple-watch-series-2-b-h-photo-video-smartwatch-smart.jpg",
  color: Colors.brown,
);
