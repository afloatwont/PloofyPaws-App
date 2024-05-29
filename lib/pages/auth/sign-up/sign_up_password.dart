import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:restoe/components/adaptive_app_bar.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/body_with_action.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/services/networking/exceptions.dart';
import 'package:restoe/services/repositories/auth/auth.dart';

class SignUpPassword extends StatefulWidget {
  final String? displayName;

  const SignUpPassword({super.key, this.displayName});

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;

  _signup() async {
    setState(() {
      _loading = true;
    });
    final AuthRepository resource = AuthRepository();
    try {
      await resource.signUp(data: {});
      // final storage = await SharedPreferences.getInstance();
      // storage.setString('auth', jsonEncode(signupResponse));
      // if (!mounted) return;
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const Root()),
      //     (Route<dynamic> route) => false);
    } on APIError catch (e) {
      print(e);
    }
    setState(() {
      _loading = false;
    });
  }

  _handleSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      _signup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      appBar: const AdaptiveAppBar(
        title: Text("Sign up"),
      ),
      body: BodyWithAction(
        action: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Button(
                loading: _loading,
                buttonIcon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                label: 'Create Account',
                onPressed: _handleSubmit,
                variant: 'filled',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        formKey: _formKey,
        body: [
          Text(
            "Ahoy, ${widget.displayName}\nYou are an amazing paw parent. \nNow, lets setup your email and password.",
            style: typography(context).title3,
          ),
          const SizedBox(height: 40),
          const InputLabel(label: 'Email'),
          FormBuilderTextField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            name: 'email',
            decoration: const InputDecoration(hintText: "Enter Email Address"),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
          const SizedBox(height: 24),
          const InputLabel(label: 'Password'),
          FormBuilderTextField(
            name: 'password',
            autofillHints: const [AutofillHints.password],
            obscureText: _isHiddenPassword,
            decoration: InputDecoration(
              hintText: 'Enter password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isHiddenPassword = !_isHiddenPassword;
                  });
                },
                icon: Icon(
                  _isHiddenPassword ? Iconsax.eye_slash : Iconsax.eye,
                  color: colors(context).common.black?.s500,
                ),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(8),
              FormBuilderValidators.maxLength(20),
            ]),
          ),
          const SizedBox(height: 24),
          const InputLabel(label: 'Confirm Password'),
          FormBuilderTextField(
            name: 'confirm_password',
            obscureText: _isHiddenConfirmPassword,
            decoration: InputDecoration(
              hintText: 'Re-enter password',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
                    });
                  },
                  icon: Icon(
                    _isHiddenConfirmPassword ? Iconsax.eye_slash : Iconsax.eye,
                    color: colors(context).common.black?.s500,
                  )),
            ),
            validator: (value) {
              if (_formKey.currentState!.fields['password']!.value != value) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
