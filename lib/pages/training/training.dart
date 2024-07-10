import 'package:flutter/material.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/training/how_it_works.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'my_pets_section.dart';
import 'grooming_packages_section.dart';
import 'expert_consultation_section.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'reviews_section.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowAddressModal();
    });
  }

  void _checkAndShowAddressModal() {
    final userProvider = context.read<UserProvider>();
    print("address status: ${userProvider.hasAddress()}");
    if (!userProvider.hasAddress()) {
      _showAddressModal();
    }
  }

  void _showAddressModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Replace this with your actual modal content
        return const AddAddressSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Training'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification click
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: PetsList(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16),
              child: GroomingPackagesSection(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16),
              child: ExpertConsultationsSection(),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ReviewsSection(),
            ),
            const Divider(thickness: 0.5, color: Colors.black),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 1.36,
              width: MediaQuery.sizeOf(context).width,
              child: const HowItWorks(),
            ),
          ],
        ),
      ),
    );
  }
}
