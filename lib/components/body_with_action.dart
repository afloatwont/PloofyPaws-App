import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ploofypaws/components/button.dart';

class BodyWithAction extends StatelessWidget {
  final Widget action;
  final EdgeInsets padding;
  final List<Widget> body;
  final GlobalKey<FormBuilderState>? formKey;
  final Map<String, dynamic> initialValue;

  const BodyWithAction({
    super.key,
    this.padding = const EdgeInsets.all(16),
    required this.body,
    required this.action,
    this.formKey,
    this.initialValue = const <String, dynamic>{},
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: formKey != null
                ? FormBuilder(
                    autovalidateMode: action is Button ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                    initialValue: initialValue,
                    key: formKey,
                    child: ListView(
                      padding: padding,
                      children: body,
                    ),
                  )
                : ListView(
                    padding: padding,
                    children: body,
                  ),
          ),
          Container(
            padding: padding,
            child: action,
          )
        ],
      ),
    );
  }
}
