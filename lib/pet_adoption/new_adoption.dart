import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/pet_adoption/adopt_me.dart';

import '../services/repositories/auth/firebase/fire_assets.dart';

class PetAdoptionScreen extends StatefulWidget {
  const PetAdoptionScreen({super.key});

  @override
  _PetAdoptionScreenState createState() => _PetAdoptionScreenState();
}

class _PetAdoptionScreenState extends State<PetAdoptionScreen> {
  String selectedCity = 'Delhi';
  Set<String> selectedPetTypes = {'All'};

  List<Map<String, dynamic>> pets = [
    {
      'name': 'Arlo',
      'age': '9 months',
      'description': 'I love to play and eat..',
      'image': 'assets/images/content/arlo.png',
      'gender': 'male',
      'breed': 'Labrador',
    },
    {
      'name': 'Bhavuk',
      'age': '11 months',
      'description': 'I love to play and eat..',
      'image': 'assets/images/content/bhavuk.png',
      'gender': 'male',
      'breed': 'Labrador',
    },
    {
      'name': 'Blacky',
      'age': '7 months',
      'description': 'I love to play and eat..',
      'image': 'assets/images/content/blacky.png',
      'gender': 'male',
      'breed': 'Labrador',
    },
  ];

  List<String> petTypes = ['All', 'Dogs', 'Cats', 'Birds', 'Rabbits'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
        ),
        centerTitle: true,
        title: const Text('Pet Adoption'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'search for pet food...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(12),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CarouselSlider(
                items: [
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, top: 30, right: 12, bottom: 20),
                      child: FutureBuilder<String>(
                        future: getImageUrl("assets/images/content/adopt.png"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            ); // Show a loading indicator while waiting
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error loading'),
                            ); // Handle any errors
                          } else if (!snapshot.hasData) {
                            return const Center(
                              child: Text('No data available'),
                            ); // Handle the case where there's no data
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }
                        },
                      )),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  initialPage: 0,
                )),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: petTypes.map((type) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: selectedPetTypes.contains(type),
                    showCheckmark: false,
                    selectedColor: Colors.grey,
                    onSelected: (selected) {
                      setState(() {
                        if (type == 'All') {
                          if (selectedPetTypes.contains('All')) {
                            selectedPetTypes.clear();
                          } else {
                            selectedPetTypes = {'All'};
                          }
                        } else {
                          if (selectedPetTypes.contains('All')) {
                            selectedPetTypes.remove('All');
                          }
                          if (selectedPetTypes.contains(type)) {
                            selectedPetTypes.remove(type);
                            if (selectedPetTypes.isEmpty) {
                              selectedPetTypes.add('All');
                            }
                          } else {
                            selectedPetTypes.add(type);
                          }
                        }
                      });
                    },
                    avatar: selectedPetTypes.contains(type) && type != 'All'
                        ? const Icon(Icons.close)
                        : null,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FutureBuilder(
                                future: getImageUrl(pet['image']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(
                                        color: Colors.black);
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Error loading'),
                                    ); // Handle any errors
                                  } else if (!snapshot.hasData) {
                                    return const Center(
                                      child: Text('No data available'),
                                    ); // Handle the case where there's no data
                                  } else {
                                    return Image.network(
                                      snapshot.data!,
                                      width: 150,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    );
                                  }
                                }),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      pet['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      pet['gender'] == 'male'
                                          ? Icons.male
                                          : Icons.female,
                                      color: pet['gender'] == 'male'
                                          ? Colors.blue
                                          : Colors.pink,
                                    ),
                                  ],
                                ),
                                Text(
                                  pet['breed'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  pet['age'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  pet['description'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle adoption action
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AdoptMePage(),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Adopt Now'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
