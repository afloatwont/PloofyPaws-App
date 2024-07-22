import 'package:flutter/material.dart';

class PropertyRow extends StatelessWidget {
  final Map<String, IconData> properties;

  const PropertyRow({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: properties.entries.map((entry) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(entry.value),
              Text(
                entry.key,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
