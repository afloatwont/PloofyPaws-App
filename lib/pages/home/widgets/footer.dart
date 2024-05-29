import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Stack(
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      "Spread the word",
                      style: typography(context).body.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      "about Restoe",
                      style: typography(context).smallBody.copyWith(),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Share the app',
                            style: typography(context).smallBody.copyWith(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
              right: -10.0, // Position the image at the right edge
              child: ClipRRect(
                // Add rounded corners to the image (optional)
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/images/placeholders/share_app_gradient.png",
                  height: 150.0,
                  // Adjust image height as needed
                ),
              ),
            ),
          ],
        ),
        // Text(
        //   "Unlocking \npawters",
        //   style: typography(context)
        //       .largeTitle
        //       .copyWith(fontSize: 26, color: Colors.grey.shade400, fontWeight: FontWeight.w900, height: 1.2),
        // ),
        // Text(
        //   "Realm!",
        //   style: typography(context)
        //       .largeTitle
        //       .copyWith(fontSize: 56, color: Colors.grey.shade400, fontWeight: FontWeight.w900),
        // ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Divider(color: colors(context).onSurface.s400),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Restoe ",
                style: typography(context).body.copyWith(color: Colors.grey.shade400),
              ),
            ),
            Expanded(
              child: Divider(color: colors(context).onSurface.s400),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
