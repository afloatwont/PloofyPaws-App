import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restoe/components/grouped_list_picker.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/pages/pet_onboarding/data/breed.dart';
import 'package:restoe/pages/pet_onboarding/widgets/stacked_cards.dart';

class AddUpdatePetType extends StatefulWidget {
  final Function(List<PetBreed>) onBreedSelected;
  final String? petName;
  final String? petType;

  final GlobalKey<FormBuilderState> formKey;

  const AddUpdatePetType({super.key, required this.onBreedSelected, this.petName, required this.formKey, this.petType});

  @override
  State<AddUpdatePetType> createState() => _AddUpdatePetTypeState();
}

class _AddUpdatePetTypeState extends State<AddUpdatePetType> {
  FocusNode myFocusNode = FocusNode();

  Future<List<PetBreed>> dummyBreedData() async {
    return [
      const PetBreed(uuid: '1', name: 'Poodle'),
      const PetBreed(uuid: '2', name: 'Bulldog'),
      // Add the rest with unique UUIDs
    ];
  }

  final List<String> _petTypeOptions = [
    'Dog',
    'Cat',
    'Bird',
    'Fish',
    'Rabbit',
    'Hamster',
    'Guinea Pig',
    'Turtle',
    'Horse',
    'Pig'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          FormBuilder(
            key: widget.formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InputLabel(label: 'What type of \npet ${widget.petName} is?', size: 36),
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
                          onTap: () async {
                            setState(() {
                              widget.formKey.currentState?.fields['pet_type']?.didChange(_petTypeOptions[index]);
                            });
                            final value = await showCupertinoModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return GroupedListPicker(
                                      listFuture: dummyBreedData, isMulti: false, name: 'select breed type');
                                });

                            if (value != null) {
                              widget.onBreedSelected(value);
                            }
                          },
                        );
                      });
                },
              )
            ]),
          ),
        ],
      ),
    );
  }
}
