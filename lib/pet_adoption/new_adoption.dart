import 'package:flutter/material.dart';

class PetAdoptionScreen extends StatefulWidget {
  const PetAdoptionScreen({super.key});

  @override
  _PetAdoptionScreenState createState() => _PetAdoptionScreenState();
}

class _PetAdoptionScreenState extends State<PetAdoptionScreen> {
  String selectedCity = 'Delhi';
  String selectedPetType = 'Dogs';

  List<Map<String, dynamic>> pets = [
    {
      'name': 'Arlo',
      'age': '9 months',
      'description': 'I love to play and eat..',
      'image': 'assets/arlo.png',
      'gender': 'male'
    },
    {
      'name': 'Bhavuk',
      'age': '11 months',
      'description': 'I love to play and eat..',
      'image': 'assets/bhavuk.png',
      'gender': 'male'
    },
    {
      'name': 'Blacky',
      'age': '7 months',
      'description': 'I love to play and eat..',
      'image': 'assets/blacky.png',
      'gender': 'male'
    },
  ];

  List<String> petTypes = ['Dogs', 'Cats', 'Birds', 'Rabbits'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: selectedCity,
                  items: <String>['Delhi', 'Mumbai', 'Chennai', 'Kolkata']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCity = newValue!;
                    });
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'search for pet food...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(12),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: petTypes.map((type) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: selectedPetType == type,
                    onSelected: (selected) {
                      setState(() {
                        selectedPetType = type;
                      });
                    },
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          pet['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(pet['name']),
                      subtitle: Text('${pet['age']}\n${pet['description']}'),
                      trailing: const Icon(Icons.male),
                      isThreeLine: true,
                      onTap: () {
                        // Handle adoption action
                      },
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
