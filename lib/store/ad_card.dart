import 'package:flutter/material.dart';

class AdCard extends StatelessWidget {
  final String link, title, price;
  const AdCard(
      {super.key,
      required this.link,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              link,
              height: 70,
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(title),
          Text(price)
        ],
      ),
    );
  }
}

const adCard = AdCard(
  link:
      "https://pyxis.nymag.com/v1/imgs/36a/39c/795d7079e8d987b2ead62a77b637f33425-bic-shampoo.rsquare.w700.jpg",
  title: "Text",
  price: "\$20",
);
