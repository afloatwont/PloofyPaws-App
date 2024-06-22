import 'package:flutter/material.dart';

import 'body.dart';

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  _StoreAppState createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const Body(),
        drawer: const Drawer(
          width: 275,
        ),
        appBar: AppBar(
          leadingWidth: 60,
          centerTitle: true,
          title: const Text(
            "Store",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 0.5,
                ),
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
