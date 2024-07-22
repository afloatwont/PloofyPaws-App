import 'package:flutter/material.dart';

class PropertyRow2 extends StatelessWidget {
  final Map<String, Widget> properties;

  const PropertyRow2({super.key, required this.properties});

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
              entry.value,
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
