import 'package:flutter/material.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class TrackerAdCard extends StatelessWidget {
  const TrackerAdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage('assets/images/placeholders/toe_tracker.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get \nYour \nTracker \nNow", style: typography(context).title2.copyWith(color: Colors.white)),
              const Spacer(),
              Row(children: [
                Button(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  onPressed: () {},
                  variant: 'filled',
                  label: "Explore",
                  buttonColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                const Spacer(),
                Text(
                  "Restoe",
                  style: typography(context).ploofypawsTitle.copyWith(color: Colors.white, fontSize: 16),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
