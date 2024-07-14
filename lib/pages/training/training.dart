import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/training/how_it_works.dart';
import 'package:ploofypaws/pages/training/other_services.dart';
import 'package:ploofypaws/pages/training/services.dart';
import 'package:ploofypaws/pages/training/video.dart';
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
            PetsList(),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GroomingPackagesSection(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SectionHeader(title: 'What we Provide'),
            ),
            ServicesGrid(),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SectionHeader(title: 'Our Grooming Specialists'),
            ),
            const VideoWidget(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ServiceCard(
                      title: 'Dog',
                      image: SvgPicture.asset(
                        'assets/svg/dog1.svg',
                        width: 45,
                        height: 60,
                      ),
                      color: Colors.brown,
                    ),
                  ),
                  Expanded(
                    child: ServiceCard(
                      title: 'Cat',
                      image: SvgPicture.asset(
                        'assets/svg/cat 1.svg',
                        height: 50,
                        width: 45,
                      ),
                      color: Colors.brown.shade200,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SectionHeader(title: 'Other Services'),
            ),
            OtherServices(),
            const Icon(Icons.lightbulb_outline_rounded, size: 100),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text('Most Asked Questions',
                  style: typography(context)
                      .title3
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('Get your answers...'),
            ),
            const FAQSection(),
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
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final Widget image;
  final Color color;

  const ServiceCard({
    super.key,
    required this.title,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                Text(
                  title,
                  style: typography(context).title1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                GestureDetector(
                  onTap: () {
                    // Add your onTap action here!
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          'Explore services',
                          style: typography(context)
                              .smallBody
                              .copyWith(color: Colors.white, fontSize: 9),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
            image,
          ],
        ),
      ),
    );
  }
}
