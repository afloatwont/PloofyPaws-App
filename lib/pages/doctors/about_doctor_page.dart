import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/controllers/time_provider.dart';
import 'package:restoe/pages/pet_onboarding/widgets/calender_widget.dart';

class AboutDoctorPage extends StatefulWidget {
  const AboutDoctorPage({super.key});

  @override
  State<AboutDoctorPage> createState() => _AboutDoctorPageState();
}

class _AboutDoctorPageState extends State<AboutDoctorPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffdaacac),
      body: SafeArea(
        child: ListView(
          children: [
            _buildHeaderImage(screenSize),
            _buildDoctorDetails(context, screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(Size screenSize) {
    return Container(
      height: screenSize.height * 0.3, // Responsive height
      width: screenSize.width,
      child: Center(
        child: Image.asset('assets/images/placeholders/women_doctor.png'),
      ),
    );
  }

  Widget _buildDoctorDetails(BuildContext context, Size screenSize) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(42),
          topRight: Radius.circular(42),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorNameAndTitle(context),
            _buildChipsRow(screenSize),
            const SizedBox(height: 45),
            _buildSectionTitle(context, 'About Doctor.'),
            _buildDoctorDescription(context),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Upcoming Schedules'),
            const SizedBox(height: 20),
            _buildUpcomingSchedule(context, screenSize),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Select Data and Time'),
            const SizedBox(height: 20),
            _buildCalendarSection(screenSize),
            _buildTimeSelection(screenSize),
            _buildConfirmButton(context, screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorNameAndTitle(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 11.0),
          child: Center(
            child: Text('Dr. Stella Kane', style: typography(context).title3),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 13.0, bottom: 25),
            child: Text('Heart Surgeon - Flower Hospitals',
                style: typography(context).subtitle2),
          ),
        ),
      ],
    );
  }

  Widget _buildChipsRow(Size screenSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyChip(
            label: '3000+',
            icon: Icons.people_outlined,
            width: screenSize.width * 0.25),
        MyChip(
            label: '7 Years',
            icon: Icons.schedule,
            width: screenSize.width * 0.25),
        MyChip(label: '4.8', icon: Icons.star, width: screenSize.width * 0.25),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: typography(context).title2.copyWith(
              fontSize: 16,
              color: const Color(0xff1E1C61),
            ),
      ),
    );
  }

  Widget _buildDoctorDescription(BuildContext context) {
    return Text(
      'Spectra 6 is a comprehensive canine vaccine formulated to shield your furry companion against six prevalent diseases. Crafted with meticulous care, this combination vaccine offers protection against the menacing threats of Canine Distemper Virus (CDV).',
      textAlign: TextAlign.justify,
      style: typography(context).body.copyWith(fontSize: 13),
    );
  }

  Widget _buildUpcomingSchedule(BuildContext context, Size screenSize) {
    return Container(
      height: screenSize.height * 0.15, // Responsive height
      width: screenSize.width,
      decoration: BoxDecoration(
        color: const Color(0xffFCFCFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE0E0E0)),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 18,
            left: 10,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xffDEE6F8),
              backgroundImage:
                  AssetImage('assets/images/placeholders/user_avatar.png'),
            ),
          ),
          Positioned(
            top: 16,
            left: screenSize.width * 0.12,
            child: Text(
              'Dr. Samira Sharma',
              style: typography(context).title2.copyWith(
                    fontSize: 14,
                    color: const Color(0xff000000),
                  ),
            ),
          ),
          Positioned(
            top: 32,
            left: screenSize.width * 0.12,
            child: Text(
              'Veterinarian (Animal welfare)',
              style: typography(context).body.copyWith(
                    fontSize: 10,
                    color: const Color(0xff000000),
                  ),
            ),
          ),
          Positioned(
            top: 44,
            left: screenSize.width * 0.12,
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 10,
                  color: Color(0xffFBBC04),
                ),
                Text(
                  '4.8',
                  style: typography(context).body.copyWith(
                        fontSize: 10,
                        color: const Color(0xff000000),
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 64,
            left: 10,
            child: Container(
              height: 24,
              width: screenSize.width * 0.5,
              decoration: BoxDecoration(
                color: const Color(0xff1E45A0),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  SvgPicture.asset('assets/svg/note-favorite.svg'),
                  const SizedBox(width: 4),
                  Text(
                    'Tues, 28 May 2024, 10:00 am IST',
                    style: typography(context).body.copyWith(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 240,
            child: Image.asset('assets/images/content/Ellipse_253.png'),
          ),
          Positioned(
            left: screenSize.width * 0.48,
            child: Image.asset('assets/images/content/Ellipse_254.png'),
          ),
          Positioned(
            top: 10,
            left: 230,
            child:
                Image.asset('assets/images/placeholders/doctor_with_pet.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(Size screenSize) {
    return Padding(
      padding: EdgeInsets.all(screenSize.width * 0.05),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffFCFCFC),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffE0E0E0)),
        ),
        child: CalendarModalSheet(),
      ),
    );
  }

  Widget _buildTimeSelection(Size screenSize) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final time = ref.watch(timeProvider);
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

  Widget _buildConfirmButton(BuildContext context, Size screenSize) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
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
}

class TimeTile extends StatelessWidget {
  final String time;

  const TimeTile({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff2828FF)),
        borderRadius: BorderRadius.circular(41.0),
      ),
      child: Text(
        time,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class MyChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final double width;

  const MyChip({
    super.key,
    required this.label,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xff000000),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
