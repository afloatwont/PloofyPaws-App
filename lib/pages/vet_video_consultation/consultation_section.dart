import 'package:flutter/material.dart';

class ConsultationSection extends StatelessWidget {
  const ConsultationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
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
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Image.asset('assets/images/placeholders/sample_dog.png'),
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
