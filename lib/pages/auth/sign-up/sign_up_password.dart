import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_app_bar.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/body_with_action.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/services/networking/exceptions.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignUpPassword extends StatefulWidget {
  final String displayName;

  const SignUpPassword({super.key, required this.displayName});

  @override
  State<SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<SignUpPassword> {
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;
  final _formKey = GlobalKey<FormBuilderState>();
  bool _loading = false;
  final GetIt _getIt = GetIt.instance;

  late AuthServices _authServices;
  late UserDatabaseService _userDatabaseService;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();
    userProvider = context.read<UserProvider>();
  }

  _signup() async {
    setState(() {
      _loading = true;
    });
    try {
      final email = _formKey.currentState!.fields['email']!.value;
      final password = _formKey.currentState!.fields['password']!.value;

      UserModel? user =
          await _authServices.signUp(email: email, password: password);
      if (user != null) {
        _userDatabaseService.createUserProfile(
          userProfile: UserModel(
            id: user.id,
            displayName: widget.displayName,
            email: email,
            photoUrl: user.photoUrl,
          ),
        );
        userProvider.update(user.id!);
      }

      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Root()),
            (Route<dynamic> route) => false);
      }
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
            "Ahoy, ${widget.displayName}\nYou are an amazing paw parent. \nNow, let's set up your email and password.",
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
