import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_date_picker.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/helpers/date_format.dart';

class AddUpdatePetDOB extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String? petName;

  const AddUpdatePetDOB({super.key, required this.formKey, this.petName});

  @override
  State<AddUpdatePetDOB> createState() => _AddUpdatePetDOBState();
}

class _AddUpdatePetDOBState extends State<AddUpdatePetDOB> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: widget.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            InputLabel(label: 'What is the \nbirth date of \n${widget.petName}?', size: 36),
            const SizedBox(height: 20),
            const InputLabel(label: 'Pet Birth Date'),
            FormBuilderTextField(
              readOnly: true,
              showCursor: false,
              enableInteractiveSelection: false,
              validator: FormBuilderValidators.required(
                errorText: 'Pet birth date is required',
              ),
              name: 'pet_date_of_birth',
              decoration: const InputDecoration(
                suffixIconColor: Colors.black,
                suffixIcon: Icon(Iconsax.calendar),
                hintText: 'Enter date of birth',
              ),
              onTap: () async {
                final initialValue = selectedDate ?? DateTime.now();
                await AdaptiveDatePicker.pickDate(
                  context,
                  disableFutureDates: true,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      this.selectedDate = selectedDate;  // Update the state with the new date
                      final formattedDate = selectedDate.toFullDate();
                      widget.formKey.currentState?.fields['pet_date_of_birth']?.didChange(formattedDate);
                    });
                  },
                );
              },
              initialValue: selectedDate?.toFullDate(),  // Use the formatted date as the initial value if available
            ),
          ],
        ),
      ),
    );
  }
}
