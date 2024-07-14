import 'package:flutter/material.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/pages/vet_video_consultation/consultation_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/expert_consultation_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/my_pets_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/services.dart';
import 'package:ploofypaws/pages/vet_video_consultation/upcoming_appointments_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/video.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MyPetsSection(),
              const PetsList(),
              const UpcomingAppointmentsSection(),
              const SizedBox(height: 16),
              const ConsultationSection(),
              const ExpertConsultationsSection(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SectionHeader(title: "What we provide"),
              ),
              ServicesGrid(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SectionHeader(title: "Our Diet Specialists"),
              ),
              const VideoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
