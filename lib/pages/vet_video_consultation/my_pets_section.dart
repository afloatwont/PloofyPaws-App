import 'package:flutter/material.dart';

class MyPetsSection extends StatelessWidget {
  final List<String> petNames = ['Arlo', 'shiro', 'chomu', 'x-hamster'];
  final List<String> petImages = [
    'assets/arlo.jpg',
    'assets/shiro.jpg',
    'assets/chomu.jpg',
    'assets/x_hamster.jpg'
  ];

  MyPetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('My Pets', style: TextStyle()),
        const SizedBox(height: 8),
        Row(
          children: [
            ...List.generate(petNames.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      // backgroundImage: AssetImage(petImages[index]),
                    ),
                    const SizedBox(height: 4),
                    Text(petNames[index]),
                  ],
                ),
              );
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: CircleAvatar(
                radius: 30,
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
