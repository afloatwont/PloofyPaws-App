import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/vet_video_consultation/consultation_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/my_pets_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/upcoming_appointments_section.dart';

class VetVideoConsultationScreen extends StatelessWidget {
  const VetVideoConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Video Consultation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button action
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyPetsSection(),
              const SizedBox(height: 16),
              UpcomingAppointmentsSection(),
              const SizedBox(height: 16),
              ConsultationSection(),
            ],
          ),
        ),
      ),
    );
  }
}
