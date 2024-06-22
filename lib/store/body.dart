import 'package:flutter/material.dart';
import 'package:ploofypaws/store/quick_pick.dart';

import 'ad_card.dart';
import 'category_card.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search_rounded),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 70,
                    height: 4,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.filter_alt,
                          size: 20,
                        ),
                        Text("filter"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(
              "Shop by Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            width: 450,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 50, crossAxisCount: 2),
              itemBuilder: (context, index) => const Row(
                children: [
                  card,
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Positioned(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 250,
                  color: Colors.orange[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Text",
                        style: TextStyle(fontSize: 25),
                      ),
                      const Text(
                        "get up to 50% off on your\nfaviourite products",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) => adCard,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 11,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: -10,
                  right: 0,
                  child: Image.network(
                      fit: BoxFit.fill,
                      height: 125,
                      "https://img.pokemondb.net/artwork/bulbasaur.jpg")),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Text(
              "Quick Picks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.0),
            child: QuickPick(),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
