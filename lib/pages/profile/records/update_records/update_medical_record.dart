import 'package:flutter/material.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/no_data_available.dart';
import 'package:restoe/config/icons/placeholders/medical_record_placeholder.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/profile/records/add_records/add_medical_record.dart';

class UpdateMedicalRecords extends StatefulWidget {
  const UpdateMedicalRecords({super.key});

  @override
  State<UpdateMedicalRecords> createState() => _UpdateMedicalRecordsState();
}

class _UpdateMedicalRecordsState extends State<UpdateMedicalRecords> with TickerProviderStateMixin {
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
      title: const Text('Medical Records'),
      appBarTrailing: Container(
        decoration: BoxDecoration(
          color: colors(context).primary.s50,
          shape: BoxShape.circle,
        ),
        child: Button(
          variant: 'text',
          buttonIcon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMedicalRecord()));
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
          Padding(
              padding: EdgeInsets.all(24.0),
              child: NoDataAvailable(
                  title: "You do not have any Medical record Please add medical record for your pet",
                  image: MedicalRecordPlaceholder())),
          Padding(
              padding: EdgeInsets.all(24.0),
              child: NoDataAvailable(
                  title: "You do not have any Medical record Please add medical record for your pet",
                  image: MedicalRecordPlaceholder())),
        ],
      ),
    );
  }
}
