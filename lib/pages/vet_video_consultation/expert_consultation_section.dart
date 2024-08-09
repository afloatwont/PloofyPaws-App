import 'package:flutter/material.dart';

class ExpertConsultationsSection extends StatelessWidget {
  ExpertConsultationsSection({super.key, this.showHeading = true});
  final bool showHeading;

  final List<String> images = [
    "assets/expert_consultations/skin.png",
    "assets/expert_consultations/digestive.png",
    "assets/expert_consultations/eye.png",
    "assets/expert_consultations/respiratory.png",
    "assets/expert_consultations/dentist.png",
    "assets/expert_consultations/ear.png",
    "assets/expert_consultations/pet.png",
    "assets/expert_consultations/not.png",
    "assets/expert_consultations/general.png",
    "assets/expert_consultations/new.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeading)
            const Text(
              'Get expert consultations on all concerns',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          const SizedBox(height: 8),
          SizedBox(
            height: MediaQuery.sizeOf(context).height *
                0.21, // Adjust height as necessary
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 5,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              shrinkWrap: true,
              children: [
                ConsultationChip(
                  label: 'Skin',
                  images: images[0],
                ),
                ConsultationChip(
                  label: 'Eye',
                  images: images[1],
                ),
                ConsultationChip(
                  label: 'Dental',
                  images: images[2],
                ),
                ConsultationChip(
                  label: 'Pet Inactive',
                  images: images[3],
                ),
                ConsultationChip(
                  label: 'General',
                  images: images[4],
                ),
                ConsultationChip(
                  label: 'Digestive',
                  images: images[5],
                ),
                ConsultationChip(
                  label: 'Respiratory',
                  images: images[6],
                ),
                ConsultationChip(
                  label: 'Ear',
                  images: images[7],
                ),
                ConsultationChip(
                  label: 'Not eating',
                  images: images[8],
                ),
                ConsultationChip(
                  label: 'New pet parent',
                  images: images[9],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConsultationChip extends StatelessWidget {
  final String label;
  final String images;

  const ConsultationChip(
      {super.key, required this.label, required this.images});

  @override
  Widget build(BuildContext context) {
    // return Chip(
    //   label: Text(label),
    //   backgroundColor: Colors.grey[200],
    //   // onTap: () {
    //   //   // Handle chip tap
    //   // },
    // );
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: AssetImage(images),
          ),
          const SizedBox(
            width: 6,
          ),
          Text(label),
        ],
      ),
    );
  }
}
