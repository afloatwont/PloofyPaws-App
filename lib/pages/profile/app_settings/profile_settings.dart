import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ploofypaws/components/body_with_action.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/input_label.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Profile Settings'),
        ),
        body: BodyWithAction(
            key: _formKey,
            body: [
              const InputLabel(label: 'Display Name'),
              FormBuilderTextField(
                name: 'displayName',
                decoration: const InputDecoration(
                  hintText: 'Enter your display name',
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const InputLabel(label: 'Email'),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
            action: Button(onPressed: () {}, variant: 'filled', label: 'Save')));
  }
}
