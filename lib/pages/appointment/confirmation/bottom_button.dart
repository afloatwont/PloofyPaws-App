import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: const ContinuousRectangleBorder(),
              fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Make Appointment   "),
                  Icon(
                    Icons.arrow_circle_right_rounded,
                    color: Colors.white,
                  )
                ],
              ),
              Text(
                "You saved Rs.69 on Arlo's healthcare",
                style:
                    typography(context).smallBody.copyWith(color: Colors.white),
              )
            ],
          ),
        ));
  }
}
