import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({
    super.key,
    required this.faqs,
    this.showTitle = false,
  });
  final List<Map<String, String>> faqs;
  final bool showTitle;

  @override
  _FAQSectionState createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  List<bool> _expanded = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _expanded = List.filled(widget.faqs.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.showTitle) ...[
            const Icon(Icons.lightbulb_outline_rounded, size: 100),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text('Most Asked Questions',
                  style: typography(context)
                      .title3
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const Text('Get your answers...'),
          ],
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.faqs.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  title: Text(
                    widget.faqs[index]["question"]!,
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
                      child: Text(widget.faqs[index]["answer"]!),
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
