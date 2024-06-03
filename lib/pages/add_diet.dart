import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/body_with_action.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/config/theme/placebo_colors.dart';

class AddDietScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dietProvider = ref.watch(dietProviderNotifier);
    return AdaptivePageScaffold(
      automaticallyImplyLeading: true,
      // previousPageTitle: 'Records',
      title: const Text("Add diet"),
      body: BodyWithAction(
          action: Button(
            onPressed: () {},
            variant: 'filled',
            label: 'Save',
            size: 16,
          ),
          body: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Does Arlo consume',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(dietProviderNotifier.notifier)
                                .setVeg(true);
                          },
                          child: Container(
                            height: 32,
                            width: 172,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    'assets/images/services/vegicon.png'),
                                const SizedBox(width: 15),
                                Text('Veg',
                                    style: TextStyle(
                                        color: dietProvider.isVeg
                                            ? Colors.green
                                            : Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            ref
                                .read(dietProviderNotifier.notifier)
                                .setVeg(false);
                          },
                          child: Container(
                            height: 32,
                            width: 172,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    'assets/images/services/nonvegicon.png'),
                                const SizedBox(width: 15),
                                Text('Non - veg',
                                    style: TextStyle(
                                        color: !dietProvider.isVeg
                                            ? Colors.red
                                            : Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildMealSection(
                    context,
                    'Morning',
                    dietProvider.morningTime,
                    (value) {
                      ref
                          .read(dietProviderNotifier.notifier)
                          .setMorningTime(value);
                    },
                    dietProvider.morningFeedController,
                  ),
                  const SizedBox(height: 20),
                  _buildMealSection(
                    context,
                    'Midday',
                    dietProvider.middayTime,
                    (value) {
                      ref
                          .read(dietProviderNotifier.notifier)
                          .setMiddayTime(value);
                    },
                    dietProvider.middayFeedController,
                  ),
                  const SizedBox(height: 20),
                  _buildMealSection(
                    context,
                    'Night',
                    dietProvider.nightTime,
                    (value) {
                      ref
                          .read(dietProviderNotifier.notifier)
                          .setNightTime(value);
                    },
                    dietProvider.nightFeedController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Does your pet consume all 3 meals?',
                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                      SizedBox(width: 30,),
                      Checkbox(
                        value: dietProvider.allMeals,
                        onChanged: (bool? value) {
                          ref
                              .read(dietProviderNotifier.notifier)
                              .setAllMeals(value!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget _buildMealSection(
    BuildContext context,
    String meal,
    String time,
    Function(String) onTimeChanged,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'What do you feed? ($meal)',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((pickedTime) {
                  if (pickedTime != null) {
                    onTimeChanged(pickedTime.format(context));
                  }
                });
              },
              child: Text(
                time,
                style: const TextStyle(
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'e.g we serve our pet with chicken gravy',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
      ],
    );
  }
}

class DietProvider extends StateNotifier<DietState> {
  DietProvider() : super(DietState());

  void setVeg(bool value) {
    state = state.copyWith(isVeg: value);
  }

  void setAllMeals(bool value) {
    state = state.copyWith(allMeals: value);
  }

  void setMorningTime(String value) {
    state = state.copyWith(morningTime: value);
  }

  void setMiddayTime(String value) {
    state = state.copyWith(middayTime: value);
  }

  void setNightTime(String value) {
    state = state.copyWith(nightTime: value);
  }
}

class DietState {
  final bool isVeg;
  final bool allMeals;
  final String morningTime;
  final String middayTime;
  final String nightTime;
  final TextEditingController morningFeedController;
  final TextEditingController middayFeedController;
  final TextEditingController nightFeedController;

  DietState({
    this.isVeg = true,
    this.allMeals = false,
    this.morningTime = 'Add time',
    this.middayTime = '4:00 pm',
    this.nightTime = '8:00 pm',
    TextEditingController? morningFeedController,
    TextEditingController? middayFeedController,
    TextEditingController? nightFeedController,
  })  : morningFeedController =
            morningFeedController ?? TextEditingController(),
        middayFeedController = middayFeedController ?? TextEditingController(),
        nightFeedController = nightFeedController ?? TextEditingController();

  DietState copyWith({
    bool? isVeg,
    bool? allMeals,
    String? morningTime,
    String? middayTime,
    String? nightTime,
    TextEditingController? morningFeedController,
    TextEditingController? middayFeedController,
    TextEditingController? nightFeedController,
  }) {
    return DietState(
      isVeg: isVeg ?? this.isVeg,
      allMeals: allMeals ?? this.allMeals,
      morningTime: morningTime ?? this.morningTime,
      middayTime: middayTime ?? this.middayTime,
      nightTime: nightTime ?? this.nightTime,
      morningFeedController:
          morningFeedController ?? this.morningFeedController,
      middayFeedController: middayFeedController ?? this.middayFeedController,
      nightFeedController: nightFeedController ?? this.nightFeedController,
    );
  }
}

final dietProviderNotifier = StateNotifierProvider<DietProvider, DietState>(
  (ref) => DietProvider(),
);
