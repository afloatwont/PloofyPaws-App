import 'package:flutter/material.dart';
import 'package:restoe/config/icons/pet_services/pet_services.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/doctors/about_doctor_page.dart';
import 'package:restoe/pages/home/core/data/services_data.dart';
import 'package:restoe/pages/home/services/pet_diet.dart';
import 'package:restoe/pages/home/services/vet_video_consultation.dart';
import 'package:restoe/pet_walking.dart';

class PetServices extends StatelessWidget {
  const PetServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      PetWalkingScreen(),
      const Placeholder(),
      const VetVideoConsultation(),
      const DietPage(),
      const Placeholder(),
      const Placeholder(),
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: petServices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final data = petServices[index];
        return Column(
          children: [
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => screens[index])),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: data.image!)),
            const SizedBox(height: 10),
            Text(
              data.title,
              style: typography(context).smallBody.copyWith(
                color: colors(context).secondary.s500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}