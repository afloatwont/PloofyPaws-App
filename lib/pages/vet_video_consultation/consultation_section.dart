import 'package:flutter/material.dart';

class ConsultationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                // backgroundImage: AssetImage('assets/consultation.jpg'),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('video call', style: TextStyle()),
                  Text('Rs. 299/-', style: TextStyle(color: Colors.green)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('✔ 30 minutes dedicated session'),
          Text('✔ Vets with 4+ years of experience'),
          Text('✔ Free follow-up chat'),
          Text('✔ Digital medical prescription'),
          Text(
              '✔ Resolve all your concerns with expert\'s consultations effectively'),
        ],
      ),
    );
  }
}
