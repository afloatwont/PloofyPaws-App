import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/pet_onboarding/pet_onboard.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/pet_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PetsList extends StatefulWidget {
  const PetsList({super.key, this.showTitle = false});
  final bool showTitle;

  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {
  List<String> petNames = [];

  void addPet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PetOnboarding(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final petProvider = context.watch<PetProvider>();
    final petsList = petProvider.pets;
    final selectedPet = petProvider.currentPet;
    final urlProvider = Provider.of<UrlProvider>(context);
    final imageUrl =
        urlProvider.urlMap['assets/images/placeholders/user_avatar.png'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTitle)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'My Pets',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                (petsList?.length ?? 0) + 1, // +1 to include the add button
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: addPet,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 26,
                          child: Icon(Icons.add, size: 26, color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0, left: 8),
                          child: Text('Add Pet'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                final petIndex = index - 1;
                final pet = petsList![petIndex];
                final isSelected = selectedPet == pet;

                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: () {
                      petProvider.setCurrentPet(pet);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 26,
                          backgroundImage: imageUrl != null
                              ? CachedNetworkImageProvider(imageUrl)
                              : null,
                          child: isSelected
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3.0,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8),
                          child: Text(
                            pet.name!,
                          ), // Dynamic name from state
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
