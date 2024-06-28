import 'package:flutter/material.dart';

class ConsultationSection extends StatelessWidget {
  const ConsultationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.53,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(150, 238, 242, 251),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 170,
                bottom:
                    0, // Adjust this value as necessary to align the cat with the button
                right: 70,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/images/content/doodle_cat.png',
                    // width: 500,
                    height: 500,
                  ),
                ),
              ),
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 69, 160),
                        foregroundColor: Colors.white,
                        fixedSize: const Size(double.maxFinite, 50)),
                    child: const Text("Make Appointment"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset('assets/images/content/puppy.jpeg',
                  fit: BoxFit.fitHeight)),
        ),
        const SizedBox(width: 16),
        const Text('video call',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text('Rs. 299/-',
            style: TextStyle(color: Colors.green, fontSize: 16)),
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
