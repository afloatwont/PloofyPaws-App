import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/no_data_available.dart';
import 'package:restoe/config/icons/placeholders/vaccination_record_placeholder.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/helpers/date_format.dart';
import 'package:restoe/pages/profile/records/add_records/add_vaccination_record.dart';
import 'package:restoe/pages/profile/records/update_records/vaccination_details.dart';

class UpdateVaccinationRecords extends StatefulWidget {
  const UpdateVaccinationRecords({super.key});

  @override
  State<UpdateVaccinationRecords> createState() => _UpdateVaccinationRecordsState();
}

class _UpdateVaccinationRecordsState extends State<UpdateVaccinationRecords> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      title: const Text('Vaccination Records'),
      appBarTrailing: Container(
        decoration: BoxDecoration(
          color: colors(context).primary.s50,
          shape: BoxShape.circle,
        ),
        child: Button(
          variant: 'text',
          buttonIcon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddVaccinationRecord()));
          },
        ),
      ),
      appBarBottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorWeight: 5,
              tabs: const <Widget>[
                Tab(
                  text: "Upcoming",
                ),
                Tab(
                  text: "History",
                ),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          UpcomingVaccinationRecords(),
          Padding(
              padding: EdgeInsets.all(24.0),
              child: NoDataAvailable(
                  title: "You do not have any Medical record \nPlease add medical record for your \npet",
                  image: VaccinationRecordPlaceholder())),
        ],
      ),
    );
  }
}

class VaccinationData {
  final int id;
  final String name;
  final DateTime date;
  final bool isCompleted;

  VaccinationData({required this.id, required this.name, required this.date, required this.isCompleted});
}

final List<VaccinationData> vaccinationData = [
  VaccinationData(id: 1, name: 'Rabies', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 2, name: 'DHLPP', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 3, name: 'Bordetella', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 4, name: 'Lyme', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 5, name: 'Leptospirosis', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 6, name: 'Coronavirus', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 7, name: 'Giardia', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 8, name: 'Canine Influenza', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 9, name: 'Heartworm', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 10, name: 'Flea & Tick', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 11, name: 'Flea & Tick', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 12, name: 'Canine Influenza', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 13, name: 'Heartworm', date: DateTime.now(), isCompleted: false),
  VaccinationData(id: 14, name: 'Flea & Tick', date: DateTime.now(), isCompleted: false),
];

class UpcomingVaccinationRecords extends StatelessWidget {
  const UpcomingVaccinationRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        height: 0,
        color: Colors.black.withOpacity(0.1),
      ),
      itemCount: vaccinationData.length,
      itemBuilder: (context, index) {
        final data = vaccinationData[index];
        return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            onTap: () {
              showCupertinoModalBottomSheet(context: context, builder: (context) => const VaccinationDetails());
            },
            leading: const Icon(
              Icons.circle,
              color: primary,
              size: 12,
            ),
            title: Text(data.name, style: typography(context).strongSmallBody),
            subtitle: Text("Due on : ${data.date.toMediumDate()}", style: typography(context).smallBody),
            trailing: const Icon(Icons.keyboard_arrow_right));
      },
    );
  }
}

class PastVaccinationRecords extends StatelessWidget {
  const PastVaccinationRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vaccinationData.length,
      itemBuilder: (context, index) {
        final data = vaccinationData[index];
        return ListTile(
          title: Text(data.name),
          subtitle: Text(data.date.toString()),
          trailing: data.isCompleted ? const Icon(Icons.check) : const Icon(Icons.close),
        );
      },
    );
  }
}
