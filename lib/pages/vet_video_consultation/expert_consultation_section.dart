import 'package:flutter/material.dart';

class ExpertConsultationsSection extends StatelessWidget {
  const ExpertConsultationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            childAspectRatio: 5,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            shrinkWrap: true,
            children: const [
              ConsultationChip(label: 'Skin'),
              ConsultationChip(label: 'Eye'),
              ConsultationChip(label: 'Dental'),
              ConsultationChip(label: 'Pet Inactive'),
              ConsultationChip(label: 'General'),
              ConsultationChip(label: 'Digestive'),
              ConsultationChip(label: 'Respiratory'),
              ConsultationChip(label: 'Ear'),
              ConsultationChip(label: 'Not eating'),
              ConsultationChip(label: 'New pet parent'),
            ],
          ),
        ),
      ],
    );
  }
}

class ConsultationChip extends StatelessWidget {
  final String label;

  const ConsultationChip({super.key, required this.label});

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
