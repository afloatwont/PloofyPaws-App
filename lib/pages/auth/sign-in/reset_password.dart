import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';

class ResetPasswordInstructions extends StatefulWidget {
  const ResetPasswordInstructions({super.key});

  @override
  State<ResetPasswordInstructions> createState() =>
      _ResetPasswordInstructionsState();
}

class _ResetPasswordInstructionsState extends State<ResetPasswordInstructions> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSuffixIconVisible = false;
  bool _loading = false;

  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;

  final TextEditingController _emailController = TextEditingController();

  String? email;

  void setSuffixIconVisibility(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isSuffixIconVisible = true;
      });
    } else {
      setState(() {
        isSuffixIconVisible = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _formKey,
              child: FormBuilderTextField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setSuffixIconVisibility(value!);
                  email = value;
                },
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  suffixIcon: isSuffixIconVisible
                      ? GestureDetector(
                          onTap: () {
                            if (_formKey.currentState?.fields['email'] != null) {
                              _formKey.currentState!.fields['email']!.didChange('');
                            }
                            _emailController.clear();
                          },
                          child: const Icon(
                            Iconsax.close_circle,
                            color: Colors.black,
                          ),
                        )
                      : null,
                ),
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.telephoneNumber,
                ],
                name: 'email',
                validator: FormBuilderValidators.email(
                  errorText: 'Please enter a valid email address',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Button(
                loading: _loading,
                onPressed: (email != null) ? () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    setState(() {
                      _loading = true;
                    });
                    await _authServices.resetPassword(email!);
                    setState(() {
                      _loading = false;
                    });
                  }
                } : null,
                variant: 'filled',
                label: 'Submit',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                          "An email with a link to reset your password will be sent to your email. Please check your inbox."),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
