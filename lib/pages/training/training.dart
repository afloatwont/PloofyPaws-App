import 'package:flutter/material.dart';
import 'my_pets_section.dart';
import 'grooming_packages_section.dart';
import 'expert_consultation_section.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'reviews_section.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Training'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification click
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PetsList(),
            const SizedBox(height: 16),
            const GroomingPackagesSection(),
            const SizedBox(height: 16),
            const ExpertConsultationsSection(),
            const SizedBox(height: 16),
            ReviewsSection(),
          ],
        ),
      ),
    );
  }
}
