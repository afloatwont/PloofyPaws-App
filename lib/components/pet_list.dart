import 'package:flutter/material.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key});

  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  List<String> petNames = ['Arlo', 'Bella', 'Charlie']; // Example initial data

  void addPet() {
    setState(() {
      petNames.add('New Pet ${petNames.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: petNames.length + 1, // +1 to include the add button
        itemBuilder: (BuildContext context, int index) {
          // Check if it's the first item (add button)
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: addPet,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 26,
                      child: Icon(Icons.add, size: 26, color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0, left: 8),
                      child: Text('Add Pet'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Adjust index to account for the add button
            final petIndex = index - 1;
            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 26,
                    backgroundImage: AssetImage(
                        'assets/images/placeholders/user_avatar.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 8),
                    child: Text(petNames[petIndex]), // Dynamic name from state
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}