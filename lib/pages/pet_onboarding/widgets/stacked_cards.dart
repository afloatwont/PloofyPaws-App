import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class StackOfCards extends StatelessWidget {
  final String? label;
  final String? imageAsset;
  final void Function()? onTap;
  const StackOfCards({
    super.key,
    this.label,
    this.imageAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0.0, right: 64.0, left: 64.0),
            child: Card(
                color: Color(0xffBBBBBB),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                  ),
                )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 40.0, left: 40.0),
            child: Card(
                color: Color(0xff858585),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/placeholders/pet_type_placeholder.png'),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label ?? 'Pet Type',
                            style: typography(context).title1.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/placeholders/sample_dog.png', height: 200),
                        ],
                      ),
                    ),

                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
