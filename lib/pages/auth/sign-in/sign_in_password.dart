import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/auth/sign-in/reset_password.dart';

class SignInPassword extends StatefulWidget {
  const SignInPassword({super.key});

  @override
  State<SignInPassword> createState() => _SignInPasswordState();
}

class _SignInPasswordState extends State<SignInPassword> {
  bool _isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enter Password'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Iconsax.arrow_left_2),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
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
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const ResetPasswordInstructions()));
                          },
                          child: const Text('Forgot password?'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Button(
                    onPressed: () {},
                    label: 'Sign in',
                    variant: 'filled',
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
