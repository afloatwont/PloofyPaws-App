import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class QuickPick extends StatelessWidget {
  const QuickPick({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: false,
          viewportFraction: 1,
        ),
        itemCount: (imgList.length / 2).round(),
        itemBuilder: (context, index, realIdx) {
          final int first = index * 2;
          final int second = first + 1;
          return Row(
            children: [first, second].map((idx) {
              return Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.network(imgList[idx], fit: BoxFit.cover),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

List<String> imgList = [
  "https://pyxis.nymag.com/v1/imgs/36a/39c/795d7079e8d987b2ead62a77b637f33425-bic-shampoo.rsquare.w700.jpg",
  "https://pyxis.nymag.com/v1/imgs/36a/39c/795d7079e8d987b2ead62a77b637f33425-bic-shampoo.rsquare.w700.jpg",
  "https://pyxis.nymag.com/v1/imgs/36a/39c/795d7079e8d987b2ead62a77b637f33425-bic-shampoo.rsquare.w700.jpg",
  "https://pyxis.nymag.com/v1/imgs/36a/39c/795d7079e8d987b2ead62a77b637f33425-bic-shampoo.rsquare.w700.jpg",
];
