import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/components/walker_modal_sheet.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/vet_video_consultation/bottom_sheet.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/doctor_provider.dart';
import 'package:provider/provider.dart';
import 'Veternian.dart';

class ConsultationSection extends StatefulWidget {
  const ConsultationSection({super.key});

  @override
  State<ConsultationSection> createState() => _ConsultationSectionState();
}

class _ConsultationSectionState extends State<ConsultationSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.53,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(150, 238, 242, 251),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          _buildButton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildBulletPoint(
                text: '30 minutes dedicated session',
                boldText: '30 minutes',
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                text: 'Vets with 4+ years of experience',
                boldText: '4+',
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                text: 'Free follow-up chat',
                boldText: 'Free',
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                text: 'Digital medical prescription',
              ),
              const SizedBox(height: 8),
              _buildBulletPoint(
                text:
                    'Resolve all your concerns with expert\'s consultations effectively',
                boldText: 'Resolve',
              ),
              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    final urlProvider = context.read<UrlProvider>();
    return LayoutBuilder(
      builder: (context, constraints) {
        final double gap = constraints.maxHeight * 0.01;

        return Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  print("pressed make appointment");
                  _showScrollableBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 69, 160),
                    foregroundColor: Colors.white,
                    fixedSize: const Size.fromWidth(double.maxFinite)),
                child: const Text("Make Appointment"),
              ),
            ),
            Positioned(
              bottom: gap,
              right: constraints.maxWidth * 0.15,
              left: constraints.maxWidth * 0.15,
              child: CachedNetworkImage(
                imageUrl:
                    urlProvider.urlMap['assets/images/content/doodle_cat.png']!,
                // height: imageHeight,
                placeholder: null,
                errorWidget: null,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    final urlProvider = context.read<UrlProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: CachedNetworkImage(
              imageUrl: urlProvider.urlMap['assets/images/content/puppy.jpeg']!,
              fit: BoxFit.fitHeight,
              placeholder: null,
              errorWidget: null,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text('Vet Video Call',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text('Rs. 299/-',
            style: TextStyle(color: Color(0xff1F6C12), fontSize: 16)),
      ],
    );
  }

  Widget _buildBulletPoint({required String text, String? boldText}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Colors.blue),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: boldText != null ? '$boldText ' : '',
              style: boldText != null
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
              children: [
                TextSpan(
                  text: boldText != null
                      ? text.replaceFirst(boldText, '').trim()
                      : text,
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _showScrollableBottomSheet(BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final docProvider = context.read<VeterinaryDoctorProvider>();
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
                        'Select Doctor',
                        style: typography(context).title3.copyWith(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: docProvider.docs!.length,
                          itemBuilder: (context, index) {
                            return VetOption(doctor: docProvider.docs![index]);
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
