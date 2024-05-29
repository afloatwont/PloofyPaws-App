import 'package:flutter/material.dart';
import 'package:restoe/components/gradient_border.dart';
import 'package:restoe/config/icons/ai.dart';
import 'package:restoe/config/theme/theme.dart';

class AICard extends StatelessWidget {
  final VoidCallback onTap;

  const AICard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colors.black,
              Color(0xff37474F),
            ], stops: [
              0.0,
              1.0
            ]),
            borderRadius: BorderRadius.circular(15),
            border: GradientBorder(
              borderGradient: LinearGradient(
                tileMode: TileMode.repeated,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xffFBBC04), colors(context).primary.s200],
                stops: const [0.2, 2.0],
              ),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              const Positioned(top: 16, right: 16, child: AIIcon()),
              Positioned(
                bottom: 3,
                right: 16,
                child: Image.asset('assets/images/placeholders/ai_pets_card.png', height: 80),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AI Pawsitive Support",
                        style: typography(context)
                            .title2
                            .copyWith(color: colors(context).common.white?.s200, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Instant Expert Advice \nfor your Beloved Pet",
                        style: typography(context).smallBody.copyWith(
                              color: colors(context).common.white?.s200,
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
