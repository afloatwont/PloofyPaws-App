import 'package:flutter/material.dart';
import 'package:ploofypaws/components/our_services.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/components/video_box.dart';
import 'package:ploofypaws/pages/vet_video_consultation/consultation_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/expert_consultation_section.dart';
import 'package:ploofypaws/pages/vet_video_consultation/upcoming_appointments_section.dart';

class VetVideoConsultationScreen extends StatelessWidget {
  VetVideoConsultationScreen({super.key});

  final List<String> ourServices = const [
    "Professional Expertise",
    "Emergency Services",
    "Prescription Refills:",
    "Tele-consultations",
    "Best in class Experience",
    "Health Alerts / Reminders",
  ];
  final List<String> images = [
    "assets/svg/proffesional.png",
    "assets/svg/emergency.png",
    "assets/svg/prescription.png",
    "assets/svg/tele.png",
    "assets/svg/best.png",
    "assets/svg/health.png",
  ];

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
              ExpertConsultationsSection(),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SectionHeader(title: "What we provide"),
              ),
              ServicesGrid(
                titles: ourServices,
                images: images,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SectionHeader(title: "Our Diet Specialists"),
              ),
              const VideoWidget(url: 'assets/images/content/CREATE_YOUR.mp4'),
            ],
          ),
        ),
      ),
    );
  }
}
