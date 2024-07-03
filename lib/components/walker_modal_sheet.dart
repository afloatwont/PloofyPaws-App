import 'package:flutter/material.dart';
import 'package:ploofypaws/controllers/time_provider.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/components/adaptive_modal_bottom_sheet.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/doctors/about_doctor_page.dart';
import 'package:ploofypaws/pages/pet_onboarding/widgets/calender_widget.dart';


class ModalSheet extends StatefulWidget {
  const ModalSheet({super.key});

  @override
  State<ModalSheet> createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
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
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showScrollableBottomSheet(context);
          },
          child: const Text('Show Modal Sheet'),
        ),
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
  return Consumer<TimeProvider>(builder: (context, timeProvider, child) {
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
                    )),
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                3,
                (_) => TimeTile(
                      time: time,
                    )),
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                3,
                (_) => TimeTile(
                      time: time,
                    )),
          ),
        ],
      ),
    );
  });
}
