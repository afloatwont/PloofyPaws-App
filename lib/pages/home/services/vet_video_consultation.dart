import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restoe/components/adaptive_app_bar.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/home/services/pet_diet.dart';
import 'package:restoe/pages/profile/widgets/pet_card.dart';

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

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      appBar: AdaptiveAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Center(
          child:
              Text('Vet Video Consultation', style: typography(context).title3),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.notifications_rounded),
          onPressed: () {},
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SectionHeader(title: 'Vet Video Consultation'),
          const PetsList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(title: 'Your Pets'),
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
          // Stack(
          //   children: [
          //     SizedBox(
          //       height: 680,
          //       child: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(top: 60.0),
          //             child: Container(
          //               height: 600,
          //               width: double.infinity,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(16),
          //                 boxShadow: [
          //                   BoxShadow(
          //                     color: Colors.grey.withOpacity(0.3),
          //                     spreadRadius: 2,
          //                     blurRadius: 5,
          //                     offset: const Offset(0, 3),
          //                   ),
          //                 ],
          //               ),
          //               child: Padding(
          //                 padding:
          //                     const EdgeInsets.only(left: 16.0, right: 16.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Center(
          //                       child: Padding(
          //                         padding: const EdgeInsets.only(top: 24.0),
          //                         child: Image.asset(
          //                           'assets/images/content/doctors.png',
          //                           height: 90,
          //                         ),
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(top: 16.0),
          //                       child: Text(
          //                         'BASIC PLAN',
          //                         style: typography(context).title3,
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(top: 16.0),
          //                       child: Row(
          //                         children: [
          //                           Text(
          //                             'Rs.14999',
          //                             style: typography(context).title1,
          //                           ),
          //                           Text(
          //                             '/Only',
          //                             style:
          //                                 typography(context).strongSmallBody,
          //                           ),
          //                         ], //
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                           top: 12.0, bottom: 20),
          //                       child: Text(
          //                         ' Beautifully simple project planning',
          //                         style: typography(context)
          //                             .body
          //                             .copyWith(color: const Color(0xff959595)),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       width: double.infinity,
          //                       child: Button(
          //                         padding: const EdgeInsets.only(
          //                             top: 10, bottom: 10),
          //                         borderRadius: BorderRadius.circular(6),
          //                         onPressed: () {},
          //                         variant: 'filled',
          //                         label: 'Get Started Now',
          //                         buttonColor: colors(context).primary.s500,
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                           top: 36.0, bottom: 20),
          //                       child: Text(
          //                         'Features',
          //                         style: typography(context).title3,
          //                       ),
          //                     ),
          //                     const CheckList(),
          //                     const SizedBox(
          //                       height: 12,
          //                     ),
          //                     const CheckList(),
          //                     const SizedBox(
          //                       height: 12,
          //                     ),
          //                     const CheckList(),
          //                     const SizedBox(
          //                       height: 12,
          //                     ),
          //                     const CheckList(),
          //                     const SizedBox(
          //                       height: 12,
          //                     ),
          //                     const CheckList()
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Positioned(
          //         left: 90,
          //         top: 40,
          //         child: Container(
          //           padding: const EdgeInsets.only(
          //               top: 10, bottom: 10, left: 22, right: 22),
          //           decoration: BoxDecoration(
          //             color: const Color(0xffF7C945),
          //             borderRadius: BorderRadius.circular(34),
          //           ),
          //           child: const Text('Most Popular'),
          //         ))
          //   ],
          // ),

          buildSwipeCards(context),
        ],
      ),
    );
  }

  Padding buildConfusedCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Container(
        height: 100,
        width: double.infinity,
        //padding: const EdgeInsets.only(top: 22, left: 12),
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
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
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
                      label: const Text("Chat with Us"))
                ],
              ),
            ),
            Image.asset(
              'assets/images/content/doctor_and_dog.png',
              height: 55,
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildSwipeCards(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
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
                        SizedBox(
                          height: 680,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: Container(
                                  height: 600,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 24.0),
                                            child: Image.asset(
                                              'assets/images/content/doctors.png',
                                              height: 90,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Text(
                                            'BASIC PLAN',
                                            style: typography(context).title3,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Rs.14999',
                                                style:
                                                    typography(context).title1,
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
                                            style: typography(context)
                                                .body
                                                .copyWith(
                                                    color: const Color(
                                                        0xff959595)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Button(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            onPressed: () {},
                                            variant: 'filled',
                                            label: 'Get Started Now',
                                            buttonColor:
                                                colors(context).primary.s500,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 36.0, bottom: 20),
                                          child: Text(
                                            'Features',
                                            style: typography(context).title3,
                                          ),
                                        ),
                                        const CheckList(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const CheckList(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const CheckList(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const CheckList(),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const CheckList()
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            left: 90,
                            top: 40,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 22, right: 22),
                              decoration: BoxDecoration(
                                color: const Color(0xffF7C945),
                                borderRadius: BorderRadius.circular(34),
                              ),
                              child: const Text('Most Popular'),
                            ))
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

class CheckList extends StatelessWidget {
  const CheckList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 10,
          backgroundColor: Colors.green,
          child: Icon(
            Icons.check,
            size: 15,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '01 Listing on  1 board for I month.',
            style: typography(context).body,
          ),
        ),
        //
      ],
    );
  }
}
