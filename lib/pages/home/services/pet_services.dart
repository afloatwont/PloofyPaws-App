import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/home/core/data/services_data.dart';
import 'package:ploofypaws/pages/home/services/pet_diet.dart';
import 'package:ploofypaws/pages/tracker/tracker.dart';
import 'package:ploofypaws/pages/training/training.dart';
import 'package:ploofypaws/pages/vet_video_consultation/vet_video_consultation.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/pet_walking.dart';

class PetServices extends StatefulWidget {
  const PetServices({
    super.key,
  });

  @override
  State<PetServices> createState() => _PetServicesState();
}

class _PetServicesState extends State<PetServices> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const PetWalkingScreen(),
      const TrainingScreen(),
      const VetVideoConsultationScreen(),
      const DietPage(),
      const Tracker(),
      const TrainingScreen(),
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: petServices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            3.0, // Adjusted to make space for icon and text horizontally
      ),
      itemBuilder: (context, index) {
        final data = petServices[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screens[index]),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
            height: 120,
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(
                  0xffee3e4f3), // Assuming a background color from theme
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.2),
              //     spreadRadius: 1,
              //     blurRadius: 5,
              //   ),
              // ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.title,
                    style: typography(context).smallBody.copyWith(
                          color: colors(context).primary.s500,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: data.image!,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
