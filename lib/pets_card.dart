import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restoe/components/gradient_text_icon.dart';
import 'package:restoe/config/theme/theme.dart';

class PetScreen extends ConsumerWidget {
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pet = ref.watch(petProvider);

    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Card(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About ${pet.name}',
                      style: typography(context)
                          .title3
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  Text(
                    pet.description,
                    style: typography(context).smallBody.copyWith(
                          fontSize: 13,
                        ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  Text('Characteristics',
                      style: typography(context).title2.copyWith(
                            fontWeight: FontWeight.w800,
                          )),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Wrap(
                    spacing: 18.0,
                    children: pet.characteristics
                        .map((char) => Chip(
                            backgroundColor: Colors.black,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            labelStyle: typography(context).preTitle.copyWith(
                                color: colors(context).common.white?.s300,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            label: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(char),
                            )))
                        .toList(),
                  ),

                  // -----------------------------------------------
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Text('Others',
                      style: typography(context)
                          .title3
                          .copyWith(fontSize: 19, fontWeight: FontWeight.w800)),
                  ListTile(
                    leading: const Icon(
                      Icons.scale_sharp,
                      size: 17,
                    ),
                    title: const Text(
                      'Size',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    trailing: Text(
                      '${pet.size} KG',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.smiley, size: 17),
                    title: const Text(
                      'Aggression',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    trailing: Text(
                      pet.aggression,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      CupertinoIcons.heart,
                      size: 17,
                    ),
                    title: const Text(
                      'Diet',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    trailing: Text(
                      pet.diet,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GradientText(
                            'ploofypaws',
                            gradient: const LinearGradient(
                              colors: <Color>[Colors.black, Color(0xFFFBBC04)],
                              begin: Alignment(-0.4, -2.0),
                              end: Alignment(0.8, 1.0),
                            ),
                            style: typography(context).title2.copyWith(
                                  fontFamily: 'Black-Mango',
                                  fontSize: 22,
                                ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share_outlined,
                              size: 19,
                            )),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  GradientText(this.text, {required this.style, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class Pet {
  final String name;
  final String description;
  final List<String> characteristics;
  final double size;
  final String aggression;
  final String diet;

  Pet({
    required this.name,
    required this.description,
    required this.characteristics,
    required this.size,
    required this.aggression,
    required this.diet,
  });
}

final petProvider = Provider<Pet>((ref) {
  return Pet(
    name: "Arlo",
    description:
        "Muscles begin to emerge subtly around the lower back and abdomen, adding a slight definition to the physique. However, abdomen, adding a slight definition to the physique.",
    characteristics: [
      "Something",
      "Something",
      "Something",
      "Something",
    ],
    size: 15.0,
    aggression: "Low",
    diet: "Non-veg",
  );
});
