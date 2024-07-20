import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/body_with_action.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/placebo_colors.dart';

class AddDietScreen extends StatelessWidget {
  const AddDietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietProvider>(context);
    return AdaptivePageScaffold(
      automaticallyImplyLeading: true,
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
                            dietProvider.setVeg(true);
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
                            dietProvider.setVeg(false);
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
                      dietProvider.setMorningTime(value);
                    },
                    dietProvider.morningFeedController,
                  ),
                  const SizedBox(height: 20),
                  _buildMealSection(
                    context,
                    'Midday',
                    dietProvider.middayTime,
                    (value) {
                      dietProvider.setMiddayTime(value);
                    },
                    dietProvider.middayFeedController,
                  ),
                  const SizedBox(height: 20),
                  _buildMealSection(
                    context,
                    'Night',
                    dietProvider.nightTime,
                    (value) {
                      dietProvider.setNightTime(value);
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
                          dietProvider.setAllMeals(value!);
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

class DietProvider with ChangeNotifier {
  bool isVeg = true;
  bool allMeals = false;
  String morningTime = 'Add time';
  String middayTime = '4:00 pm';
  String nightTime = '8:00 pm';
  final TextEditingController morningFeedController = TextEditingController();
  final TextEditingController middayFeedController = TextEditingController();
  final TextEditingController nightFeedController = TextEditingController();

  void setVeg(bool value) {
    isVeg = value;
    notifyListeners();
  }

  void setAllMeals(bool value) {
    allMeals = value;
    notifyListeners();
  }

  void setMorningTime(String value) {
    morningTime = value;
    notifyListeners();
  }

  void setMiddayTime(String value) {
    middayTime = value;
    notifyListeners();
  }

  void setNightTime(String value) {
    nightTime = value;
    notifyListeners();
  }
}


