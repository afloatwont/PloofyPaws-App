import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/create_pet_memorial.dart';

class Memories extends StatefulWidget {
  const Memories({super.key});

  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Memories"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PetMemorialScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                height: 70,
                width: 100,
                child: const Stack(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.grey,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Angad",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text("I am a parent of Arlo and Meoww"),
              const SizedBox(height: 20),
              const TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 100),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.normal),
                tabs: [
                  Tab(text: "Photos"),
                  Tab(text: "Videos"),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Photos Content")),
                    Center(child: Text("Videos Content")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}