import 'package:flutter/material.dart';
import 'package:ploofypaws/components/walker_modal_sheet.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'Veternian.dart';

class VetBottomSheet extends StatefulWidget {
  const VetBottomSheet(BuildContext context, {super.key});

  @override
  State<VetBottomSheet> createState() => _VetBottomSheetState();
}

class _VetBottomSheetState extends State<VetBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

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
                            color: Colors.black,
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
