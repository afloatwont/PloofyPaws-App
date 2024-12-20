import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/grouped_list_picker.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/pages/pet_onboarding/breeds.dart';
import 'package:ploofypaws/pages/pet_onboarding/data/breed.dart';
import 'package:ploofypaws/pages/pet_onboarding/widgets/stacked_cards.dart';

class AddUpdatePetType extends StatefulWidget {
  final Function(List<PetBreed>) onBreedSelected;
  final String? petName;
  final String? petType;

  final GlobalKey<FormBuilderState> formKey;

  const AddUpdatePetType({
    super.key,
    required this.onBreedSelected,
    this.petName,
    required this.formKey,
    this.petType,
  });

  @override
  State<AddUpdatePetType> createState() => _AddUpdatePetTypeState();
}

class _AddUpdatePetTypeState extends State<AddUpdatePetType> {
  FocusNode myFocusNode = FocusNode();

  final List<String> _petTypeOptions = [
    'Dog',
    'Cat',
    'Bird',
    'Fish',
    'Rabbit',
    'Hamster',
    'Turtle',
    'Other',
  ];

  final List<String> _images = [
    'assets/images/content/dogs.png',
    'assets/images/content/cat.png',
    'assets/images/content/parrot.png',
    'assets/images/content/fish.png',
    'assets/images/content/rabbit.png',
    'assets/images/content/hamster.png',
    'assets/images/content/turtle.png',
    'assets/images/content/turtle.png',
  ];

  final Map<String, List<String>> _breedOptions = {
    'Dog': dogBreeds,
    'Cat': catBreeds,
    'Bird': birdBreeds,
    'Rabbit': rabbitBreeds,
    'Hamster': hamsterBreeds,
    'Turtle': turtleBreeds,
    'Fish': fishBreeds,
    'Other': ['Other'],
  };

  Future<List<PetBreed>> getBreedData(String petType) async {
    if (_breedOptions.containsKey(petType)) {
      return _breedOptions[petType]!
          .map((name) => PetBreed(uuid: name, name: name))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          FormBuilder(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InputLabel(
                    label: 'What type of \npet ${widget.petName} is?',
                    size: 36,
                  ),
                ),
                FormBuilderField(
                  name: 'pet_type',
                  builder: (FormFieldState<dynamic> field) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _petTypeOptions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return StackOfCards(
                          label: _petTypeOptions[index],
                          imageAsset: _images[index],
                          onTap: () async {
                            setState(() {
                              widget.formKey.currentState?.fields['pet_type']
                                  ?.didChange(_petTypeOptions[index]);
                            });

                            if (_breedOptions
                                .containsKey(_petTypeOptions[index])) {
                              final value = await showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return GroupedListPicker(
                                    listFuture: () =>
                                        getBreedData(_petTypeOptions[index]),
                                    isMulti: false,
                                    name: 'select breed type',
                                  );
                                },
                              );

                              if (value != null) {
                                widget.onBreedSelected(value);
                              }
                            } else {
                              widget.onBreedSelected([]);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
