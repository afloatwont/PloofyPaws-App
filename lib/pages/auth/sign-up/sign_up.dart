import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/pet_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/icons/google.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/auth/sign-in/sign_in.dart';
import 'package:ploofypaws/pages/auth/sign-up/sign_up_password.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/services/networking/exceptions.dart';
import 'package:ploofypaws/services/repositories/auth/auth.dart';
import 'package:ploofypaws/services/repositories/auth/model.dart' as models;
import '../../../services/repositories/auth/firebase/fire_assets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSuffixIconVisible = false;
  bool _loading = false;
  bool _googleLoading = false;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
  }

  void _handleSignUp(String? firstName, String? lastName) {
    setState(() {
      _loading = true;
    });
    try {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignUpPassword(
                    displayName: '$firstName $lastName',
                  )));
    } catch (e) {
      print(e);
    }
    setState(() {
      _loading = false;
    });
  }

  void _handleGoogleLogin() async {
    setState(() {
      _googleLoading = true;
    });
    try {
      final authServices = GetIt.instance.get<AuthServices>();
      final databaseService = GetIt.instance.get<UserDatabaseService>();
      print("Inside glogin");
      final user = await authServices.signInWithGoogle();
      print("Inside glogin");
      if (!(await databaseService.isEmailAlreadyRegistered(user!.email!))) {
        await databaseService.createUserProfile(
            userProfile: UserModel(
                id: user!.id,
                displayName: user.displayName,
                email: user.email,
                photoUrl: user.photoUrl));
        print("Inside glogin");
      }

      userProvider.setUser(user);
      final storage = await SharedPreferences.getInstance();
      storage.setString('auth', jsonEncode(user));

          final petProvider = context.read<PetProvider>();
      userProvider.setUser(user);
       databaseService
          .getAllPetsForUser(authServices.user!.uid)
          .then((value) {
          setState(() {
            print(value?[0].name);
            petProvider.setPets(value);
          });
        
      });

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Root(),
        ),
        (route) => false,
      );
    } on APIError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    setState(() {
      _googleLoading = false;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      _handleSignUp(data['firstName'], data['lastName']);
    }
  }

  models.UserData? userData;

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    final signUpImageUrl = urlProvider.urlMap['assets/images/auth/sign-up.png'];

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Sign Up',
                  style: typography(context).title1,
                  textAlign: TextAlign.left, // Align text to the left
                ),
              ),
              Hero(
                tag: 'sign-up-cat',
                child: signUpImageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: signUpImageUrl,
                        height: 80,
                        placeholder: null,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : const CircularProgressIndicator(),
              )
            ],
          ),
          FormBuilder(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 4),
                children: [
                  const InputLabel(label: 'First Name'),
                  FormBuilderTextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "e.g. Angad",
                    ),
                    autofillHints: const [
                      AutofillHints.namePrefix,
                    ],
                    name: 'firstName',
                    validator: FormBuilderValidators.required(
                      errorText: 'First name is required',
                    ),
                  ),
                  const SizedBox(height: 24),
                  const InputLabel(label: 'Last Name'),
                  FormBuilderTextField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "e.g. Singh",
                    ),
                    autofillHints: const [
                      AutofillHints.namePrefix,
                    ],
                    name: 'lastName',
                    validator: FormBuilderValidators.required(
                      errorText: 'Last name is required',
                    ),
                  ),
                  const SizedBox(height: 40),
                  Button(
                    loading: _loading,
                    onPressed: _handleSubmit,
                    variant: 'filled',
                    label: 'Next',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(color: colors(context).onSurface.s400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR', style: typography(context).body),
                      ),
                      Expanded(
                        child: Divider(color: colors(context).onSurface.s400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Button(
                    loading: _googleLoading,
                    onPressed: _handleGoogleLogin,
                    variant: 'outlined',
                    label: 'Sign up with Google',
                    iconAsset: const GoogleIcon(
                      height: 24,
                    ),
                    buttonColor: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Already have an account?",
                        style: typography(context).smallBody.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          'Sign in',
                          style: typography(context).strong.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
