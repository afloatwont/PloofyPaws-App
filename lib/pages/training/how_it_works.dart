import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepList(),
            ProGrid(),
            FAQSection(),
          ],
        ),
      ),
    );
  }
}

class StepList extends StatelessWidget {
  StepList({super.key});

  final List<String> steps = [
    "Removal of items from cabinets and trolleys",
    "Spraying the chemicals and removing grease stains from cabinets exterior using steam machine",
    "Removal of stains, cobwebs and bad odour from cabinet interior using steam machine",
    "Placing back the items inside cabinets and trolleys"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      height: MediaQuery.of(context).size.height * 0.42,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 245, 236, 236),
      ),
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.08,
            bottom: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              width: 1,
              color: Colors.grey,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "How it works",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              ...steps.asMap().entries.map((entry) {
                int idx = entry.key + 1;
                String text = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 12,
                            child: Text(
                              "$idx",
                              style: const TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          text,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class ProGrid extends StatelessWidget {
  ProGrid({super.key});

  final List<String> pros = [
    "Specialised Professionals",
    "Innovative power steam cleaner",
    "10x stain removal",
    "2x long lasting shine"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
      height: MediaQuery.of(context).size.height * 0.54,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "The UC difference",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
          const Text(
            "Systematic cleaning using suitable tools & curated chemicals",
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 242, 216, 213),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      pros[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
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
