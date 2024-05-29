import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/pages/pet_onboarding/data/breed.dart';

class AddUpdateExtraDetails extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  const AddUpdateExtraDetails({super.key, required this.formKey});

  @override
  State<AddUpdateExtraDetails> createState() => _AddUpdateExtraDetailsState();
}

class _AddUpdateExtraDetailsState extends State<AddUpdateExtraDetails> {
  late Future<List<PetExtraDetails>> _extraDetailsFuture;

  final Set<String> _selectedDetails = {};

  @override
  void initState() {
    super.initState();
    _extraDetailsFuture = dummyExtraDetailsData();
  }

  Future<List<PetExtraDetails>> dummyExtraDetailsData() async {
    return [
      const PetExtraDetails(uuid: '1', name: 'Vaccinated'),
      const PetExtraDetails(uuid: '2', name: 'Neutered'),
      const PetExtraDetails(uuid: '3', name: 'Microchipped'),
      const PetExtraDetails(uuid: '4', name: 'House Trained'),
      const PetExtraDetails(uuid: '5', name: 'Leash Trained'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: InputLabel(label: 'Select extra details for your pet:', size: 34),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<PetExtraDetails>>(
              future: _extraDetailsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final details = snapshot.data!;
                  return FormBuilder(
                    key: widget.formKey,
                    child: FormBuilderField(
                      name: 'pet_extra_details',
                      initialValue: _selectedDetails.toList(),
                      builder: (FormFieldState<dynamic> field) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          itemCount: details.length,
                          itemBuilder: (context, index) {
                            final detail = details[index];
                            return PetDetailCheckbox(
                              key: ValueKey(detail.uuid), // Unique key for maintaining state
                              detail: detail,
                              isSelected: _selectedDetails.contains(detail.uuid),
                              onChanged: (bool value) {
                                if (value) {
                                  _selectedDetails.add(detail.uuid);
                                } else {
                                  _selectedDetails.remove(detail.uuid);
                                }
                                field.didChange(_selectedDetails.toList());
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PetDetailCheckbox extends StatelessWidget {
  final PetExtraDetails detail;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const PetDetailCheckbox({
    super.key,
    required this.detail,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: const BorderSide(color: Colors.transparent),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      title: Text(detail.name),
      value: isSelected,
      onChanged: (bool? value) {
        onChanged(value ?? false);
      },
    );
  }
}
