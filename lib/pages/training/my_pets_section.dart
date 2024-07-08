import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyPetsSection extends StatelessWidget {
  const MyPetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Pets",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          children: [
            PetAvatar(petName: 'XYZ'),
            SizedBox(width: 8),
            PetAvatar(petName: 'XYZ'),
          ],
        ),
      ],
    );
  }
}

class PetAvatar extends StatelessWidget {
  final String petName;

  const PetAvatar({super.key, required this.petName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blueGrey.shade50,
          radius: 24,
          child: const Icon(
            Icons.pets_outlined,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(petName),
      ],
    );
  }
}
