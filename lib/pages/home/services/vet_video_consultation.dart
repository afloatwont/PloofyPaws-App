import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/controllers/time_provider.dart';
import 'package:ploofypaws/pages/doctors/about_doctor_page.dart';
import 'package:ploofypaws/pages/vet_video_consultation/Veternian.dart';
import 'package:ploofypaws/pages/pet_onboarding/widgets/calender_widget.dart';

class VetVideoConsultation extends StatefulWidget {
  const VetVideoConsultation({super.key});

  @override
  State<VetVideoConsultation> createState() => _VetVideoConsultationState();
}

class _VetVideoConsultationState extends State<VetVideoConsultation> {
  final PageController _controller =
      PageController(viewportFraction: 0.8, initialPage: 0);

  final List<Map<String, dynamic>> cardDAta = [
    {
      'name': 'Arlo',
      'type': 'Beagle',
      'species': 'Dog',
      'gender': 'Male',
      'age': '2 years old',
      'image': 'assets/images/placeholders/pet_card_placeholder.png'
    },
    {
      'name': 'Bella',
      'type': 'Labrador',
      'species': 'Dog',
      'gender': 'Female',
      'age': '3 years old',
      'image': 'assets/images/placeholders/pet_card_placeholder.png'
    }
  ];

  void _showScrollableBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select walker',
                          style: typography(context).title3.copyWith(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorListScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'View all',
                            style: typography(context).body.copyWith(
                                  color: const Color(0xff1A24DE),
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return const VetOption(label: 'Dr.Angad Singh');
                            }),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xffE0E0E0),
                    ),
                    buildCalenderPart(screenSize),
                    buildtime(screenSize),
                    buildbutton(context, screenSize)
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimeProvider(),
      child: AdaptivePageScaffold(
        appBar: AdaptiveAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Center(
            child: Text('Vet Video Consultation', style: typography(context).title3),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {},
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SectionHeader(title: 'Your Pets'),
            const PetsList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionHeader(title: 'Training packages for XYZ'),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View all',
                    style: typography(context).body.copyWith(
                          color: const Color(0xff1A24DE),
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
            buildConfusedCard(context),
            buildSwipeCards(context),
          ],
        ),
      ),
    );
  }

  Padding buildConfusedCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Confused about Training',
                      style: typography(context).strongSmallBody,
                    ),
                  ),
                  Chip(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 8, right: 8),
                    backgroundColor: colors(context).primary.s500,
                    labelStyle: typography(context)
                        .strongSmallBody
                        .copyWith(color: Colors.white),
                    label: const Text("Chat with Us"),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/content/doctor_and_dog.png',
              height: 55,
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildSwipeCards(BuildContext context) {
    return SizedBox(
      height: 600,
      child: PageView.builder(
        controller: _controller,
        itemCount: cardDAta.length + 1, // +1 for the 'Add a pet' card
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = 1.0;
              if (_controller.position.haveDimensions) {
                scale = _controller.page! - index;
                scale = (1 - (scale.abs() * 0.2)).clamp(0.8, 1.0);
              } else {
                scale = index == 0
                    ? 1.0
                    : 0.8; // Default scale for the initial load
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    height: Curves.easeInOut.transform(scale) *
                        MediaQuery.of(context).size.height *
                        0.6,
                    width: Curves.easeInOut.transform(scale) *
                        MediaQuery.of(context).size.width *
                        0.8,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 24.0),
                                      child: Image.asset(
                                        'assets/images/content/doctors.png',
                                        height: 90,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      'BASIC PLAN',
                                      style: typography(context).title3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Rs.14999',
                                          style: typography(context).title1,
                                        ),
                                        Text(
                                          '/Only',
                                          style: typography(context)
                                              .strongSmallBody,
                                        ),
                                      ], //
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, bottom: 20),
                                    child: Text(
                                      ' Beautifully simple project planning',
                                      style: typography(context).body.copyWith(
                                          color: const Color(0xff959595)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Button(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      borderRadius: BorderRadius.circular(6),
                                      onPressed: () {
                                        _showScrollableBottomSheet(context);
                                      },
                                      variant: 'filled',
                                      label: 'Get Started Now',
                                      buttonColor: colors(context).primary.s500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 125,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 22, right: 22),
                            decoration: BoxDecoration(
                              color: const Color(0xffF7C945),
                              borderRadius: BorderRadius.circular(34),
                            ),
                            child: const Text('Most Popular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VetOption extends StatelessWidget {
  final String label;

  const VetOption({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildbutton(BuildContext context, Size screenSize) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: SizedBox(
      height: 50,
      width: screenSize.width,
      child: Button(
        borderRadius: BorderRadius.circular(42),
        onPressed: () {},
        variant: 'filled',
        label: 'Confirm',
        buttonColor: colors(context).primary.s500,
        foregroundColor: Colors.white,
      ),
    ),
  );
}

Widget buildCalenderPart(Size screenSize) {
  return Padding(
    padding: EdgeInsets.all(screenSize.width * 0.05),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xffFCFCFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE0E0E0)),
      ),
      child: const CalendarModalSheet(),
    ),
  );
}

Widget buildtime(Size screenSize) {
  return Consumer<TimeProvider>(
    builder: (_, timeProvider, __) {
      final time = timeProvider.time;
      return Padding(
        padding: EdgeInsets.all(screenSize.width * 0.03),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (_) => TimeTile(
                  time: time,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (_) => TimeTile(
                  time: time,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (_) => TimeTile(
                  time: time,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
