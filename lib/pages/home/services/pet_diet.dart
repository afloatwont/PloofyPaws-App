import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/home/services/diet/recipe.dart';
import 'package:ploofypaws/pages/home/services/nutrititon.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/pet_list.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/controllers/card_selection_provider.dart';

class DietPage extends StatelessWidget {
  const DietPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectionNotifier(),
      child: AdaptivePageScaffold(
        appBar: AdaptiveAppBar(
          bottom: const Divider(color: Color(0xffD6D6D6)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Center(
            child: Text('Diet', style: typography(context).title3),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {},
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            SectionHeader(title: 'My Pets'),
            PetsList(showTitle: false),
            SectionHeader(title: "Arlo’s analysis"),
            CalorieCard(),
            NutritionalEnhancementsCard(),
            SectionHeader(title: 'Food Recipes'),
            DietPreferences(),
            FoodRecipesList(),
            ShowMoreButton(),
          ],
        ),
      ),
    );
  }
}

class CalorieCard extends StatelessWidget {
  const CalorieCard({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = context.read<UserProvider>().user?.pets ?? [];
    int cal = pets[0].calculateDailyCalories();
    int meal = pets[0].calculateNumberOfMeals();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Recommended calorie',
                  style: typography(context).title3.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                ),
              ),
              Row(
                children: [
                  Text(
                    cal.toString() ?? '1150',
                    style: typography(context).title3.copyWith(
                          fontSize: 42,
                          color: Colors.white,
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Kcal Over',
                      style: typography(context).title3.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                child: Text(
                  'Body Condition : Ideal',
                  style: typography(context).title3.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                ),
              ),
              Row(
                children: [
                  const MyButton(),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      "${meal.toString()} Meals/Day " ?? '2 Meals/Day',
                      style: typography(context).title3.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: Image.asset('assets/svg/breakfastCard.png'))
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 48),
      child: Row(
        children: [
          SvgPicture.asset('assets/svg/veg_green.svg'),
          const SizedBox(width: 8),
          Text(
            'Veg',
            style: typography(context).title3.copyWith(
                  fontSize: 10,
                  color: const Color(0xff8C8C8C),
                ),
          ),
        ],
      ),
    );
  }
}

class NutritionalEnhancementsCard extends StatelessWidget {
  const NutritionalEnhancementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset('assets/images/content/fish_bowl_art.png'),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customized Nutritional Enhancements:',
                    style: typography(context).largeBody.copyWith(
                          fontSize: 11,
                        ),
                  ),
                  Text(
                    'Create Fully Personalized Recipes with Expert Nutritional Guidance',
                    softWrap: true,
                    style: typography(context).body.copyWith(
                          color: const Color(0xff909090),
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodRecipesList extends StatelessWidget {
  const FoodRecipesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipePage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xffD6D6D6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/content/fish_bowl_art.png'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            'Diet',
                            style: typography(context).title3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                            'Excellent support!',
                            style: typography(context).body.copyWith(
                                  color: const Color(0xff525252),
                                  fontSize: 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DietPreferences extends StatelessWidget {
  const DietPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    final selectionState = context.watch<SelectionNotifier>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SelectionButton(
          label: 'Non-veg',
          isSelected: selectionState.isNonVegSelected,
          onPressed: () => context.read<SelectionNotifier>().toggleNonVeg(),
        ),
        const SizedBox(width: 20),
        SelectionButton(
          label: 'Veg',
          isSelected: selectionState.isVegSelected,
          onPressed: () => context.read<SelectionNotifier>().toggleVeg(),
        ),
      ],
    );
  }
}

class SelectionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectionButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? (label == 'Non-veg' ? Colors.red.shade50 : Colors.green.shade50)
              : Colors.grey.shade200,
          border: Border.all(
            color: isSelected
                ? (label == 'Non-veg' ? Colors.red : Colors.green)
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (label == 'Non-veg' ? Icons.warning : Icons.check_circle)
                  : Icons.close,
              color: isSelected
                  ? (label == 'Non-veg' ? Colors.red : Colors.green)
                  : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowMoreButton extends StatelessWidget {
  const ShowMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const NutritionScreen(),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colors(context).primary.s500,
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Unlock More',
                textAlign: TextAlign.center,
                style: typography(context).smallBody.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.lock_open_rounded,
                    size: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
