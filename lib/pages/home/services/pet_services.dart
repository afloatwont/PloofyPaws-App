import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/home/core/data/services_data.dart';

class PetServices extends StatelessWidget {
  const PetServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            ClipRRect(borderRadius: BorderRadius.circular(50), child: data.image!),
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
