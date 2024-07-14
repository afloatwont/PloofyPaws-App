import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/selected_plan_provider.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:video_player/video_player.dart';

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
                        recommended: index == 2
                            ? const Color(0xffeFDEDE0)
                            : Colors.white,
                        onTap: () {
                          context.read<SelectedPlanProvider>().selectedPlan =
                              plans[index];
                        },
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                ServicesGrid(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SectionHeader(title: 'Our Walking Specialists'),
                ),
                const VideoWidget(),
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
                const FAQSection(),
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
}

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  _FAQSectionState createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
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
  List<bool> _expanded = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _expanded = List.filled(faqs.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ExpansionTile(
                  title: Text(
                    faqs[index]["question"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    _expanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _expanded[index] = expanded;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faqs[index]["answer"]!),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OtherServices extends StatelessWidget {
  OtherServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the size for each item based on the available width
          double itemWidth = (constraints.maxWidth - 24.0) / 2;
          double itemHeight = itemWidth * 0.6; // Adjust height as needed

          return GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0, // Adjust spacing as needed
              mainAxisSpacing: 8.0, // Adjust spacing as needed
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              return _buildServiceItem(_titles[index], itemWidth, itemHeight);
            },
          );
        },
      ),
    );
  }

  // List of titles
  final List<String> _titles = [
    "Pet Grooming",
    "Ploofy-Diet",
    "Behaviourist",
    "Vet Video Call",
  ];

  Widget _buildServiceItem(String title, double width, double height) {
    return Container(
      height: height * 0.6,
      width: width * 0.8,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/content/memories_bg.png'), // Add your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              fixedSize: Size(width * 0.8, height * 0.2),
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: const Text(
              'Explore services',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/images/content/CREATE_YOUR.mp4')
          ..initialize().then((_) {
            _controller.setLooping(true);
            _controller.play();
            setState(
                () {}); // To refresh the widget after the video has initialized
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.24,
        color: Colors.transparent,
        child: FutureBuilder(
          future: _controller.initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: VideoPlayer(_controller)),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ServicesGrid extends StatelessWidget {
  ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the size for each item based on the available width
          double itemWidth = (constraints.maxWidth - 24.0) / 3;
          double itemHeight = itemWidth;

          return GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              return _buildServiceItem(_titles[index], itemWidth, itemHeight);
            },
          );
        },
      ),
    );
  }

  // List of titles
  final List<String> _titles = [
    "Real-Time Tracking",
    "Paw Cleaning",
    "Poop Scooping",
    "Flexible Time",
    "Fixed Walker",
    "Pet Exercised",
  ];

  Widget _buildServiceItem(String title, double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * 0.5,
          width: width * 0.5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
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
                          child:
                              Image.asset("assets/images/content/offer.png")),
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
                        child: Image.asset("assets/images/content/offer.png")),
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
  final Color recommended;

  const PlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
    this.recommended = Colors.white,
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
          elevation: 0,
          child: Container(
            margin: edgeInsets,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xffeBBA593) : recommended,
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
                              color: isSelected ? Colors.black : Colors.black)),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                        plan.description,
                        style: typography(context).smallBody.copyWith(
                              fontSize: 12,
                              color: isSelected ? Colors.black : Colors.black,
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
                              color: isSelected ? Colors.black : Colors.black,
                              fontSize: 12,
                            ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      Text(
                        plan.originalPrice,
                        style: typography(context).smallBody.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: isSelected ? Colors.black : Colors.black,
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
