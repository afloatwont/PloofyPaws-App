import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/profile/records/pet_records.dart';

class PetCard extends StatelessWidget {
  final Map<String, dynamic> pet;
  final double scale;

  const PetCard({
    super.key,
    required this.pet,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                pet['image'],
                height: scale * MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(pet['name'], style: typography(context).restoeTitle.copyWith(color: Colors.amber)),
                Button(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(context, MaterialWithModalsPageRoute(builder: (context) => const PetRecords()));
                  },
                  variant: 'text',
                  label: 'View Records',
                  buttonColor: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(pet['type'], style: typography(context).body.copyWith(color: Colors.white)),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(pet['species'],
                    textAlign: TextAlign.end, style: typography(context).smallBody.copyWith(color: Colors.white)),
                Text(pet['gender'],
                    textAlign: TextAlign.end, style: typography(context).smallBody.copyWith(color: Colors.white)),
                Text(pet['age'],
                    textAlign: TextAlign.end, style: typography(context).smallBody.copyWith(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
