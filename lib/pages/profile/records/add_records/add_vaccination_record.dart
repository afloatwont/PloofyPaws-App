import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restoe/components/adaptive_date_picker.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/body_with_action.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/helpers/date_format.dart';
import 'package:restoe/pages/profile/records/widgets/file_picker.dart';

class AddVaccinationRecord extends StatefulWidget {
  const AddVaccinationRecord({super.key});

  @override
  State<AddVaccinationRecord> createState() => _AddVaccinationRecordState();
}

class _AddVaccinationRecordState extends State<AddVaccinationRecord> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<File> files = [];
  DateTime? lastVaccinationDate;
  bool loading = false;

  uploadVaccinationRecord() async {
    setState(() {
      loading = true;
    });
    try {
      final formData = _formKey.currentState!.value;
      // final vaccinationName = formData['vaccination_name'];
      // final lastVaccinationDate = formData['last_vaccination_date'];
      // final nextVaccinationDate = formData['next_vaccination_date'];
      // final extraNotes = formData['extra_notes'];
      // final selectedFiled = files;
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  _handleSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      uploadVaccinationRecord();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        previousPageTitle: 'Records',
        title: const Text('Vaccination'),
        body: BodyWithAction(
          formKey: _formKey,
          action: Button(onPressed: _handleSubmit, variant: 'filled', label: 'Add Vaccination Record'),
          body: [
            const InputLabel(label: "Vaccination Name"),
            FormBuilderDropdown(name: 'vaccination_name', items: const []),
            const SizedBox(height: 24),
            const InputLabel(label: "Last Vaccination Date"),
            FormBuilderTextField(
              readOnly: true,
              showCursor: false,
              enableInteractiveSelection: false,
              validator: FormBuilderValidators.required(
                errorText: 'Last vaccination date is required',
              ),
              name: 'last_vaccination_date',
              decoration: const InputDecoration(
                suffixIconColor: Colors.black,
                suffixIcon: Icon(Iconsax.calendar),
                hintText: 'Last vaccination date',
              ),
              onTap: () async {
                await AdaptiveDatePicker.pickDate(
                  context,
                  disableFutureDates: true,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      lastVaccinationDate = selectedDate; // Update the state with the new date
                      final formattedDate = selectedDate.toFullDate();
                      _formKey.currentState?.fields['last_vaccination_date']?.didChange(formattedDate);
                    });
                  },
                );
              },
              initialValue:
                  lastVaccinationDate?.toFullDate(), // Use the formatted date as the initial value if available
            ),
            const SizedBox(height: 24),
            DocumentPicker(
              files: files,
              inputLabel: "Upload vaccination certificate (optional) ",
              maxFiles: 3,
            ),
            const SizedBox(height: 24),
            const InputLabel(label: "Next Vaccination Date"),
            FormBuilderTextField(
              readOnly: true,
              showCursor: false,
              enableInteractiveSelection: false,
              validator: FormBuilderValidators.required(
                errorText: 'Next vaccination date is required',
              ),
              name: 'next_vaccination_date',
              decoration: const InputDecoration(
                suffixIconColor: Colors.black,
                suffixIcon: Icon(Iconsax.calendar),
                hintText: 'Next vaccination date',
              ),
              onTap: () async {
                await AdaptiveDatePicker.pickDate(
                  context,
                  disableFutureDates: false,
                  min: DateTime.now(),
                  onDateSelected: (selectedDate) {
                    setState(() {
                      lastVaccinationDate = selectedDate; // Update the state with the new date
                      final formattedDate = selectedDate.toFullDate();
                      _formKey.currentState?.fields['next_vaccination_date']?.didChange(formattedDate);
                    });
                  },
                );
              },
              initialValue:
                  lastVaccinationDate?.toFullDate(), // Use the formatted date as the initial value if available
            ),
            const SizedBox(height: 14),
            const InputLabel(
              label: "We will remind you when vaccination is due",
              required: true,
              size: 12,
            ),
            const SizedBox(height: 24),
            //extra notes
            const InputLabel(label: "Extra Notes (optional)"),
            FormBuilderTextField(
              name: 'extra_notes',
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'e.g. Any specific instructions from the vet?',
              ),
            ),
          ],
        ));
  }
}
