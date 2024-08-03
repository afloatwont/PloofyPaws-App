import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ploofypaws/controllers/time_provider.dart';
import 'package:ploofypaws/pages/appointment/confirmation/appointment_confirm.dart';
import 'package:ploofypaws/razorpay/payment_razorpay.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/doctor_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/doctor_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/package_provider.dart';
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
    final docProvider = context.watch<VeterinaryDoctorProvider>();
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
                              return VetOption(doctor: docProvider.docs![0]);
                            }),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Color(0xffE0E0E0),
                    ),
                    buildCalenderPart(screenSize),
                    buildtime(screenSize),
                    buildbutton(context, screenSize, () {}),
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

class VetOption extends StatefulWidget {
  final VeterinaryDoctor doctor;

  const VetOption({super.key, required this.doctor});

  @override
  State<VetOption> createState() => _VetOptionState();
}

class _VetOptionState extends State<VetOption> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final packageProvider = context.read<PackageProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => packageProvider
          .setName(widget.doctor.name ?? "Vet Video Consultation"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final docProvider = context.watch<VeterinaryDoctorProvider>();
    return GestureDetector(
      onTap: () {
        docProvider.setDoctor(widget.doctor);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: widget.doctor == docProvider.doctor
                      ? Colors.grey
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: widget.doctor == docProvider.doctor
                          ? Colors.black
                          : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: widget.doctor == docProvider.doctor
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 8,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.doctor.name!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildbutton(BuildContext context, Size screenSize, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 20),
    child: SizedBox(
      height: 50,
      width: screenSize.width,
      child: Button(
        borderRadius: BorderRadius.circular(42),
        onPressed: () {
          onTap();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AppointmentConfirmation()));
        },
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
  // Helper function to format time
  String formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }

  // Generate a list of times incremented by 1 hour
  List<String> generateTimes(int count, DateTime startTime) {
    return List.generate(count, (index) {
      DateTime time = startTime.add(Duration(hours: index));
      return formatTime(time);
    });
  }

  // Starting time (you can change this to whatever start time you prefer)
  DateTime startTime =
      DateTime(2024, 7, 23, 6, 30); // Example start time: 6:30 AM

  return Consumer<TimeProvider>(builder: (context, timeProvider, child) {
    List<String> times = generateTimes(12, startTime);

    return Padding(
      padding: EdgeInsets.all(screenSize.width * 0.03),
      child: Column(
        children: List.generate(
          4,
          (rowIndex) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    3,
                    (colIndex) {
                      int index = rowIndex * 3 + colIndex;
                      return TimeTile(
                        time: times[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14.0), // Add spacing between rows
              ],
            );
          },
        ),
      ),
    );
  });
}
