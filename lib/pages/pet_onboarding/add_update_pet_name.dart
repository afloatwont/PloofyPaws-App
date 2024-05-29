import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:restoe/components/input_label.dart';

class AddUpdatePetName extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;

  const AddUpdatePetName({super.key, required this.formKey});

  @override
  State<AddUpdatePetName> createState() => _AddPetNameState();
}

class _AddPetNameState extends State<AddUpdatePetName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: widget.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const InputLabel(label: 'What is the \nname of your \npet?', size: 36),
            const SizedBox(height: 20),
            const InputLabel(
              label: 'Pet Name',
            ),
            FormBuilderTextField(
              name: 'pet_name',
              validator: FormBuilderValidators.required(
                errorText: 'Pet name is required',
              ),
              decoration: const InputDecoration(
                hintText: 'e.g Arlo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
