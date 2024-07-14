
import 'package:flutter/material.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  _FAQSectionState createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  final List<Map<String, String>> faqs = [
    {
      "question": "What is included in the pet walking package?",
      "answer":
          "The pet walking package includes daily walks, feeding, and playtime."
    },
    {
      "question": "How long are the walks?",
      "answer":
          "Each walk lasts for about 30 minutes to an hour, depending on your pet's needs."
    },
    {
      "question": "Are the walkers trained and certified?",
      "answer":
          "Yes, all our walkers are trained and certified to handle pets of all sizes and breeds."
    },
  ];
  List<bool> _expanded = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _expanded = List.filled(faqs.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ExpansionTile(
                  title: Text(
                    faqs[index]["question"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    _expanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      _expanded[index] = expanded;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faqs[index]["answer"]!),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}