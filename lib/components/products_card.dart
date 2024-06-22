import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});
  final imgPath =
      "https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGhlYWRwaG9uZXN8ZW58MHx8MHx8fDA%3D";

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
                color: const Color.fromARGB(255, 255, 0, 0),
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