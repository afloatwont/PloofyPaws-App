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

class AddMedicalRecord extends StatefulWidget {
  const AddMedicalRecord({super.key});

  @override
  State<AddMedicalRecord> createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  List<File> files = [];
  DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        previousPageTitle: 'Records',
        title: const Text('Medical Record'),
        body: BodyWithAction(
          formKey: _formKey,
          action: Button(onPressed: () {}, variant: 'filled', label: 'Add Medical Record'),
          body: [
            const InputLabel(label: "Medicine Name"),
            FormBuilderTextField(
              name: 'medicine_name',
              validator: FormBuilderValidators.required(
                errorText: 'Medicine name is required',
              ),
              decoration: const InputDecoration(
                hintText: 'e.g. Paracetamol',
              ),
            ),
            const SizedBox(height: 24),
            DocumentPicker(
              files: files,
              inputLabel: "Upload prescription (optional) ",
            ),
            const SizedBox(height: 24),
            const InputLabel(label: "Due  Date"),
            FormBuilderTextField(
              readOnly: true,
              showCursor: false,
              enableInteractiveSelection: false,
              validator: FormBuilderValidators.required(
                errorText: 'Due date is required',
              ),
              name: 'due_date',
              decoration: const InputDecoration(
                suffixIconColor: Colors.black,
                suffixIcon: Icon(Iconsax.calendar),
                hintText: 'Due date',
              ),
              onTap: () async {
                await AdaptiveDatePicker.pickDate(
                  context,
                  disableFutureDates: true,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      dueDate = selectedDate; // Update the state with the new date
                      final formattedDate = selectedDate.toFullDate();
                      _formKey.currentState?.fields['due_date']?.didChange(formattedDate);
                    });
                  },
                );
              },
              initialValue: dueDate?.toFullDate(), // Use the formatted date as the initial value if available
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
