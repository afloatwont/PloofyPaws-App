import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ploofypaws/components/adaptive_dropdown_menu.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/pet_onboarding/data/breed.dart';

class AddUpdatePetSize extends StatefulWidget {
  final PetBreed? selected; //
  final GlobalKey<FormBuilderState> formKey;
  final String? petName;

  const AddUpdatePetSize({super.key, this.selected, required this.formKey, this.petName});

  @override
  State<AddUpdatePetSize> createState() => _AddUpdatePetSizeState();
}

class _AddUpdatePetSizeState extends State<AddUpdatePetSize> {
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FormBuilder(
      key: widget.formKey,
      child: ListView(padding: const EdgeInsets.all(16.0), children: [
        InputLabel(label: 'What is the \nsize of ${widget.petName} \n(${widget.selected?.name})?', size: 36),
        const SizedBox(height: 20),
        const InputLabel(label: 'Pet Size'),
        FormBuilderTextField(
          autofocus: true,
          name: 'pet_size',
          validator: FormBuilderValidators.required(errorText: 'Pet size is required'),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: 'e.g Small, Medium, Large',
              suffixIcon: AdaptiveDropdownMenu(
                  options: const [
                    AdaptiveMenuOption(title: 'Kgs'),
                    AdaptiveMenuOption(title: 'Lbs'),
                    AdaptiveMenuOption(title: 'Gms'),
                  ],
                  onTap: (value) {
                    setState(() {
                      _selectedSize = value.title;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_selectedSize ?? 'Kgs',
                          style: typography(context).smallBody.copyWith(
                                color: Colors.grey,
                              )),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ))),
        ),
      ]),
    ));
  }
}
