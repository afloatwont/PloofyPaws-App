import 'package:flutter/material.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/components/tag.dart';
import 'package:ploofypaws/config/theme/theme.dart';

final List<String> _sampleSideEffect = [
  "Fever",
  "Tingling at the site of exposure",
  "Violent movements",
  "Uncontrolled excitement",
  "Fear of water",
  "Inability to move parts of the body",
  "Confusion",
  "Loss of consciousness",
];

class VaccinationDetails extends StatelessWidget {
  const VaccinationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(
                label: "Vaccination Details",
                size: 36,
              ),
              SizedBox(height: 16),
              //due date
              InputLabel(
                label: "Due Date: 24th May 2022",
                size: 16,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 12,
                  color: primary,
                ),
                const SizedBox(width: 8),
                Text(
                  "Rabies",
                  style: typography(context).smallBody.copyWith(
                        color: Colors.white,
                      ),
                ),
                const Spacer(),
                Button(onPressed: () {}, variant: 'text', label: "View Evidence", buttonColor: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InputLabel(
                label: "About the Vaccination",
                size: 24,
              ),
              const SizedBox(height: 16),
              Text(
                "Rabies is a viral disease that causes inflammation of the brain in humans and other mammals. Early symptoms can include fever and tingling at the site of exposure. These symptoms are followed by one or more of the following symptoms: violent movements, uncontrolled excitement, fear of water, an inability to move parts of the body, confusion, and loss of consciousness.",
                style: typography(context).smallBody.copyWith(
                      color: colors(context).onSurface.s600,
                    ),
              ),
              const SizedBox(height: 16),
              const InputLabel(
                label: "Side Effects",
                size: 24,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _sampleSideEffect
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: colors(context).warning.s400,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                e,
                                style: typography(context).smallBody.copyWith(
                                      color: colors(context).onSurface.s600,
                                    ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Dose",
                          style: typography(context).strongSmallBody.copyWith(color: colors(context).primary.s500)),
                      const SizedBox(height: 16),
                      const Tag(
                        label: "1 ml",
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Age Group",
                          style: typography(context).strongSmallBody.copyWith(color: colors(context).primary.s500)),
                      const SizedBox(height: 16),
                      const Tag(
                        label: "6-12 months",
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Effectiveness",
                          style: typography(context).strongSmallBody.copyWith(color: colors(context).primary.s500)),
                      const SizedBox(height: 16),
                      const Tag(
                        label: "98%",
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              //add common FAQs about vaccination expand list tile
              const InputLabel(
                label: "FAQs",
                size: 24,
              ),
            ],
          ),
        ),
        const FAQList(),
      ],
    ));
  }
}

class FAQList extends StatelessWidget {
  const FAQList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FAQExpansionTile(
          question: 'Are there any side effects of vaccines?',
          answer:
              'Your puppy may seem a little withdrawn or might get a mild fever in response to the immune system reacting to the vaccine.',
        ),
        SizedBox(height: 16),
        FAQExpansionTile(
          question: 'What should and shouldn\'t puppies do after the vaccination?',
          answer:
              'After the vaccination, the puppies should rest in a calm and quiet place as their system is working hard to protect their bodies from the new vaccine. They should be fed high-quality food and given plenty of water. However, if you find that your puppy hasn’t recovered and bounced back to normal activity in 24-48 hours, you should get in touch with a veterinarian.',
        ),
        SizedBox(height: 16),
        FAQExpansionTile(
          question: 'Do puppies need annual booster doses?',
          answer: 'Yes, puppies need annual booster doses for parvovirus, hepatitis, and distemper.',
        ),
        SizedBox(height: 16),
        FAQExpansionTile(
          question: 'What is the 5 in 1 vaccination for dogs?',
          answer:
              'Commonly known as DHPP, the 5 in 1 vaccination protects canines against diseases like hepatitis, parainfluenza, distemper virus, kennel cough, and parvovirus.',
        ),
        SizedBox(height: 16),
        FAQExpansionTile(
          question: 'What is the 7 in 1 vaccine for dogs?',
          answer:
              'Canine Distemper, Hepatitis, Corona Viral Enteritis, Parainfluenza, Parvovirus, and Leptospirosis are all protected by the 7-in-1 vaccine for dogs.',
        ),
      ],
    );
  }
}

class FAQExpansionTile extends StatelessWidget {
  final String question;
  final String answer;

  const FAQExpansionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
