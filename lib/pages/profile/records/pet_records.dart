import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/gradient_header.dart';
import 'package:restoe/components/gradient_text_icon.dart';
import 'package:restoe/config/icons/verified.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/profile/records/add_records/add_diet.dart';
import 'package:restoe/pages/profile/records/add_records/add_medical_record.dart';
import 'package:restoe/pages/profile/records/add_records/add_vaccination_record.dart';
import 'package:restoe/pages/profile/records/upcoming_week_events.dart';
import 'package:restoe/pages/profile/records/update_records/update_medical_record.dart';
import 'package:restoe/pages/profile/records/update_records/update_vaccination_record.dart';
import 'package:restoe/pages/profile/records/widgets/pet_record_card.dart';

class PetRecords extends StatefulWidget {
  const PetRecords({super.key});

  @override
  State<PetRecords> createState() => _PetRecordsState();
}

class _PetRecordsState extends State<PetRecords> {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        previousPageTitle: 'My Pets',
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                showCupertinoModalBottomSheet(context: context, builder: (context) => const UpcomingDaysEvents());
              },
              child: GradientHeader(
                title: Text(
                  'View sessions for upcoming week for arlo',
                  style: typography(context).strongSmallBody.copyWith(
                        color: Colors.white,
                      ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    shadowColor: Colors.black.withOpacity(0.25),
                    child: ListTile(
                      leading: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Iconsax.weight, color: Colors.black, size: 24),
                        ),
                      ),
                      title: GradientText(
                        text: '15 Kgs',
                        gradient: LinearGradient(
                            colors: [colors(context).primary.s500, colors(context).warning.s500],
                            stops: const [0.01, 0.2]),
                      ),
                      subtitle: Text('Last Record on 12th July 2021',
                          style: typography(context).smallBody.copyWith(color: Colors.grey, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PetRecordCard(
                    leading: const Icon(Icons.food_bank, color: Colors.white),
                    color: Colors.black,
                    isViewRecordVisible: false,
                    titleStyle: typography(context).strongSmallBody.copyWith(color: Colors.white),
                    title: 'Diet',
                    subtitle: 'To better understand Arlo’s health, lets include details about arlo’s diet',
                    onAddRecord: () {
                      // Add a new diet record
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDiet()));
                    },
                    onViewRecord: () {},
                  ),
                  const SizedBox(height: 24),
                  PetRecordCard(
                    leading: const Icon(Iconsax.health, color: Colors.black),
                    isViewRecordVisible: true,
                    title: "Health Records",
                    trailing: const RestoeVerifiedIcon(),
                    subtitle: "Health records and medical history",
                    onAddRecord: () {
                      Navigator.push(
                          context, MaterialWithModalsPageRoute(builder: (context) => const AddMedicalRecord()));
                    },
                    onViewRecord: () {
                      Navigator.push(
                          context, MaterialWithModalsPageRoute(builder: (context) => const UpdateMedicalRecords()));
                    },
                  ),
                  const SizedBox(height: 24),
                  PetRecordCard(
                    leading: const Icon(Icons.heart_broken, color: Colors.black),
                    isViewRecordVisible: true,
                    title: "Vaccinations",
                    trailing: const RestoeVerifiedIcon(),
                    subtitle: "Vaccination records and due dates",
                    onAddRecord: () {
                      Navigator.push(
                          context, MaterialWithModalsPageRoute(builder: (context) => const AddVaccinationRecord()));
                    },
                    onViewRecord: () {
                      Navigator.push(
                          context, MaterialWithModalsPageRoute(builder: (context) => const UpdateVaccinationRecords()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
