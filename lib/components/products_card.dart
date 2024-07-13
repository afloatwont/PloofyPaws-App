import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});
  final imgPath =
      "https://i0.wp.com/puppiesareprozac.com/wp-content/uploads/2009/04/orange-tabby-kitten-in-box.jpg?w=333&ssl=1";

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: const BorderRadius.vertical(
                    top: const Radius.circular(8.0)),
                image: DecorationImage(
                  image: NetworkImage(imgPath),
                  // Replace with your asset image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TEXT', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4.0),
                Text('HEADPHONES'),
                SizedBox(height: 4.0),
                Text('9 months old'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
