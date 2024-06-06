import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/config/theme/theme.dart';

class PetWalkingScreen extends StatelessWidget {
  PetWalkingScreen({super.key});
  final selectedPlanProvider = StateProvider<String>((ref) => 'Trial Walk');

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      centertitle: true,
      //  previousPageTitle: 'My Pets',
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Pets'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      ),
      title: const Text('Pet walking'),
      // -----------body---------------------------------
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: plans.length,
                itemBuilder: (context, index) {
                  return PlanCard(plan: plans[index]);
                },
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
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
                      //---------------------------dog image---------------------------

                      image: SvgPicture.asset(
                        'assets/svg/dog1.svg',
                        width: 45,
                        height: 60,
                      ), // Placeholder for dog image
                      color: Colors.brown,
                    ),
                  ),
                  Expanded(
                    child: ServiceCard(
                      title: 'Cat',
                      //---------------------------cat image---------------------------
                      image: SvgPicture.asset(
                        'assets/svg/cat 1.svg',
                        height: 50,
                        width: 45,
                      ), // Placeholder for cat image
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
    );
  }
}

// ----------------------------------plan offer cards----------------------------
class PlanCard extends StatelessWidget {
  final Plan plan;

  PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    var edgeInsets = const EdgeInsets.all(3);
    return Card(
      // surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        margin: edgeInsets,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: plan.gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        // ------------------card-design---------------------------
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan.title,
                      style: typography(context)
                          .title2
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                  Text(
                    plan.description,
                    style: typography(context).smallBody.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(plan.price,
                      style: typography(context)
                          .strong
                          .copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(
                    plan.originalPrice,
                    style: typography(context).smallBody.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------plancard-model----------------------------------
class Plan {
  final String title;
  final String price;
  final String originalPrice;
  final String description;
  final Gradient? gradient;

  Plan({
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.description,
    this.gradient,
  });
}

// ---------------------------------------demo data-------------------------------
final List<Plan> plans = [
  Plan(
    title: 'Trial Walk',
    price: 'Rs 99',
    originalPrice: 'Rs 199',
    description: '1 day, 1 time',
    gradient: LinearGradient(
      colors: [Colors.pink.shade100, Colors.pink.shade50],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  Plan(
    title: 'Monthly Plan',
    price: 'Rs 4499',
    originalPrice: 'Rs 6099',
    description: 'Once every day for a month',
  ),
  Plan(
    title: 'Special Monthly Plan',
    price: 'Rs 8499',
    originalPrice: 'Rs 10099',
    description: 'Twice every day for a month',
  ),
  Plan(
    title: 'Quarterly Plan',
    price: 'Rs 10999',
    originalPrice: 'Rs 12999',
    description: 'Once every day for 90 days',
  ),
  Plan(
    title: 'Special Quarterly Plan',
    price: 'Rs 10999',
    originalPrice: 'Rs 12999',
    description: 'Once every day for 90 days',
  ),
];

// --------------------------------servicecascrd------------------------------------------
class ServiceCard extends StatelessWidget {
  final String title;
  final Widget image;
  final Color color;

  const ServiceCard(
      {super.key,
      required this.title,
      required this.image,
      required this.color});

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
                  child: Container(
                    // width: 90,
                    // height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
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
            image
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