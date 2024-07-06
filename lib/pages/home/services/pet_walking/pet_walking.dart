import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/selected_plan_provider.dart';
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

class _PetWalkingScreenState extends State<PetWalkingScreen> with WidgetsBindingObserver {
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
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: SectionHeader(title: 'Packages Name'),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
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
                Text('Services for cats and dogs',
                    style: typography(context).title3.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                Row(
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
                const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                Text('Testimonials',
                    style: typography(context)
                        .title3
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
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
    return Card(
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
                        Text(date, style: const TextStyle(color: Colors.grey)),
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
    );
  }
}
