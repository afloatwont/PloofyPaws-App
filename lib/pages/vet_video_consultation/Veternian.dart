import 'package:flutter/material.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/doctor_card.dart';
import 'package:ploofypaws/pages/doctors/about_doctor_page.dart';

class DoctorListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> doctorData = [
    {
      'name': 'Dr. Samira Sharma',
      'rating': 4.7,
      'reviews': 1042,
      'specialty': 'Animal welfare',
      'experience': 8,
      'responseTime': '1 Hour',
    },
    {
      'name': 'Dr. Samira Sharma',
      'rating': 4.7,
      'reviews': 1042,
      'specialty': 'Animal welfare',
      'experience': 8,
      'responseTime': '1 Hour',
    },
    {
      'name': 'Dr. Samira Sharma',
      'rating': 4.7,
      'reviews': 1042,
      'specialty': 'Animal welfare',
      'experience': 8,
      'responseTime': '1 Hour',
    },
    {
      'name': 'Dr. Samira Sharma',
      'rating': 4.7,
      'reviews': 1042,
      'specialty': 'Animal welfare',
      'experience': 8,
      'responseTime': '1 Hour',
    },
  ];

   DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      title: const Text('Veterinarian'),
      automaticallyImplyLeading: true,
      appBarTrailing: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Ploofypaw’s Top Doctors',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(7),
                  height: 32,
                  width: 78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        size: 17,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: doctorData.length,
              itemBuilder: (context, index) {
                final doctor = doctorData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutDoctorPage()));
                  },
                  child: DoctorCard(
                    name: doctor['name'],
                    rating: doctor['rating'],
                    reviews: doctor['reviews'],
                    specialty: doctor['specialty'],
                    experience: doctor['experience'],
                    responseTime: doctor['responseTime'],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}