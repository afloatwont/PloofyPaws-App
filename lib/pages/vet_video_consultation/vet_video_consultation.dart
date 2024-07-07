import 'package:flutter/material.dart';
import 'package:ploofypaws/components/pet_list.dart';
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
            Navigator.pop(context);
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MyPetsSection(),
              PetsList(),
              UpcomingAppointmentsSection(),
              SizedBox(height: 16),
              ConsultationSection(),
            ],
          ),
        ),
      ),
    );
  }
}
