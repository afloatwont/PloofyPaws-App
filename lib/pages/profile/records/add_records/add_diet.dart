import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/body_with_action.dart';
import 'package:ploofypaws/components/button.dart';

class AddDiet extends StatefulWidget {
  const AddDiet({super.key});

  @override
  State<AddDiet> createState() => _AddDietState();
}

class _AddDietState extends State<AddDiet> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        title: const Text('Diet'),
        body: BodyWithAction(
            body: const [],
            action: Button(
              onPressed: () {},
              variant: 'filled',
              label: "Save",
            ),
            formKey: _formKey));
  }
}
