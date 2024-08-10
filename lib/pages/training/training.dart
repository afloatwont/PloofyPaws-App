import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ploofypaws/components/faq_section.dart';
import 'package:ploofypaws/components/other_services.dart';
import 'package:ploofypaws/components/our_services.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/components/video_box.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'grooming_packages_section.dart';
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

  final List<Map<String, String>> faqs = [
    {
      "question": "What is included in the pet walking package?",
      "answer":
          "The pet walking package includes daily walks, feeding, and playtime."
    },
    {
      "question": "How long are the walks?",
      "answer":
          "Each walk lasts for about 30 minutes to an hour, depending on your pet's needs."
    },
    {
      "question": "Are the walkers trained and certified?",
      "answer":
          "Yes, all our walkers are trained and certified to handle pets of all sizes and breeds."
    },
  ];

  final List<String> otherServices = [
    "Pet Grooming",
    "Ploofy-Diet",
    "Behaviourist",
    "Vet Video Call",
  ];

  final List<String> ourServices = [
    "Real-Time Tracking",
    "Paw Cleaning",
    "Poop Scooping",
    "Flexible Time",
    "Fixed Walker",
    "Pet Exercised",
  ];

  final List<String> images = [
    "assets/svg/proffesional.png",
    "assets/svg/emergency.png",
    "assets/svg/prescription.png",
    "assets/svg/tele.png",
    "assets/svg/best.png",
    "assets/svg/health.png",
  ];
  final List<String> otherimages = [
    "assets/other_services/groom.png",
    "assets/other_services/diet.png",
    "assets/other_services/dog.png",
    "assets/other_services/vc.png",
  ];
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
            const PetsList(),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GroomingPackagesSection(
                type: "Training",
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SectionHeader(title: 'What we Provide'),
            ),
            ServicesGrid(
              titles: ourServices,
              images: images,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SectionHeader(title: 'Our Grooming Specialists'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: VideoWidget(url: 'assets/images/content/training.mp4'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    child: ServiceCard(
                      title: 'Dog',
                      image: 'assets/svg/dog.png',
                      color: Colors.brown,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ServiceCard(
                      title: 'Cat',
                      image: 'assets/svg/cat.png',
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
            OtherServices(
              titles: otherServices,
              otherimages: otherimages,
            ),
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
            FAQSection(faqs: faqs),
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
  final String image;
  final Color color;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   color: color,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
    //         Text(
    //           title,
    //           style: Theme.of(context).textTheme.titleMedium?.copyWith(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w800,
    //                 fontSize: 16,
    //               ),
    //         ),
    //         const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
    //         Image(
    //           image: image,
    //           width: 45, // Adjust width as needed
    //           height: 50, // Adjust height as needed
    //           fit: BoxFit.cover,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Container(
      width: 172,
      height: 58,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFB78F6F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1, // Adjust height as needed
                letterSpacing: -0.32,
              ),
            ),
          ),
          Positioned(
            left: 106,
            top: -4,
            child: Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image), // Local image path
                  fit: BoxFit.cover, // Adjust fit as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
