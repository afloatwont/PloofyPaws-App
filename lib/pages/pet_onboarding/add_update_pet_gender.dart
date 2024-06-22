import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ploofypaws/components/input_label.dart';

class AddUpdatePetGender extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String? petName;

  const AddUpdatePetGender({super.key, required this.formKey, this.petName});

  @override
  State<AddUpdatePetGender> createState() => _AddUpdatePetGenderState();
}

class _AddUpdatePetGenderState extends State<AddUpdatePetGender> {
  final List<String> _genderOptions = ["Male", "Female", "I'm not sure"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: widget.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            InputLabel(
              label: 'What is the \ngender of \n${widget.petName}?',
              size: 36,
            ),
            const SizedBox(height: 20),
            _buildGenderRadioGroup(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderRadioGroup() {
    return FormBuilderRadioGroup<String>(
      name: 'pet_gender',
      validator: FormBuilderValidators.required(),
      controlAffinity: ControlAffinity.trailing,
      orientation: OptionsOrientation.vertical,
      wrapSpacing: 30,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.zero,
        enabledBorder: InputBorder.none,
      ),
      itemDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      wrapRunAlignment: WrapAlignment.spaceBetween,
      initialValue: _genderOptions.first,
      options: _genderOptions
          .map((gender) => FormBuilderFieldOption(
                value: gender,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(width: double.infinity, child: Text(gender)),
                ),
              ))
          .toList(),
    );
  }
}
