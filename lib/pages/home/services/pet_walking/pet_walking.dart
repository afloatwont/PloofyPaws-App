import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/components/faq_section.dart';
import 'package:ploofypaws/components/other_services.dart';
import 'package:ploofypaws/components/our_services.dart';
import 'package:ploofypaws/components/video_box.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/appointment/confirmation/appointment_confirm.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/selected_plan_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';

class PetWalkingScreen extends StatefulWidget {
  const PetWalkingScreen({super.key});

  @override
  _PetWalkingScreenState createState() => _PetWalkingScreenState();
}

class _PetWalkingScreenState extends State<PetWalkingScreen>
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
    final selectedPlan = context.watch<SelectedPlanProvider>().selectedPlan;
    final plans = context.watch<SelectedPlanProvider>().plans;

    return Scaffold(
      body: AdaptivePageScaffold(
        centertitle: true,
        appBar: AdaptiveAppBar(
          bottom: const Divider(color: Color(0xffD6D6D6)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Center(
            child: Text('Pet Walking', style: typography(context).title3),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SectionHeader(title: 'My Pets'),
                ),
                const PetsList(),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Offers(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SectionHeader(title: 'Packages Name'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      return PlanCard(
                        plan: plans[index],
                        isSelected: plans[index].title == selectedPlan.title,
                        onTap: () {
                          context.read<SelectedPlanProvider>().selectedPlan =
                              plans[index];
                          Package selected = Package(
                              name: plans[index].title,
                              price:
                                  (int.parse(plans[index].price.split(" ")[1])),
                              content: [plans[index].description]);
                          context.watch<PackageProvider>().setPackage(selected);
                        },
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppointmentConfirmation(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: colors(context).primary.s500,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: typography(context).smallBody.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SectionHeader(title: 'What we Provide'),
                ),
                ServicesGrid(titles: ourServices),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SectionHeader(title: 'Our Walking Specialists'),
                ),
                const VideoWidget(url: 'assets/images/content/CREATE_YOUR.mp4'),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Pets Included',
                      style: typography(context).title3.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ServiceCard(
                          title: 'Dog',
                          image: SvgPicture.asset(
                            'assets/svg/dog1.svg',
                            width: 45,
                            height: 50,
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
                OtherServices(titles: otherServices),
                const Icon(Icons.lightbulb_outline_rounded, size: 100),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Text('Testimonials',
                      style: typography(context)
                          .title3
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                const TestimonialCard(
                  name: 'Samaira Sharma',
                  rating: 5,
                  date: '5/05/2024',
                  feedback: 'Excellent support!',
                ),
                const TestimonialCard(
                  name: 'Samaira Sharma',
                  rating: 5,
                  date: '5/05/2024',
                  feedback: 'Excellent support!',
                ),
              ],
            ),
          ),
        ),
      ),
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
}

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.07,
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  decoration: BoxDecoration(
                    color: const Color(0xffe775940),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Iconsax.percentage_circle,
                        color: Colors.white,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Save 10% on every order",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12),
                          ),
                          Text(
                            "Book a package now",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                      Flexible(
                        child: CachedNetworkImage(
                          imageUrl: urlProvider
                              .urlMap["assets/images/content/offer.png"]!,
                          placeholder: null,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
                height: MediaQuery.sizeOf(context).height * 0.07,
                padding: const EdgeInsets.all(10),
                width: MediaQuery.sizeOf(context).width * 0.6,
                decoration: BoxDecoration(
                  color: const Color(0xffeB49357),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Iconsax.percentage_circle,
                      color: Colors.white,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cashback upto Rs. 300",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12),
                        ),
                        Text(
                          "Book a package now",
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                    Flexible(
                      child: CachedNetworkImage(
                        imageUrl: urlProvider
                            .urlMap["assets/images/content/offer.png"]!,
                        placeholder: null,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final Plan plan;
  final bool isSelected;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var edgeInsets = const EdgeInsets.all(3);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Container(
            margin: edgeInsets,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.white,
              gradient: isSelected ? null : plan.gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.title,
                          style: typography(context).title2.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black)),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                        plan.description,
                        style: typography(context).smallBody.copyWith(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan.price,
                        style: typography(context).smallBody.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 12,
                            ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                        plan.originalPrice,
                        style: typography(context).smallBody.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
            Text(
              title,
              style: typography(context).title1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
            image,
          ],
        ),
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final String name;
  final int rating;
  final String date;
  final String feedback;

  const TestimonialCard({
    super.key,
    required this.name,
    required this.rating,
    required this.date,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Text(name[0]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: typography(context)
                            .subtitle1
                            .copyWith(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(
                              rating,
                              (index) => const Icon(Icons.star,
                                  color: Colors.yellowAccent, size: 18),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7)),
                          Text(date,
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Text(feedback,
                        style: typography(context)
                            .smallBody
                            .copyWith(color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
