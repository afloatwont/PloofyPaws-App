import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/icons/google.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/auth/sign-in/reset_password.dart';
import 'package:ploofypaws/pages/auth/sign-in/sign_in_otp.dart';
import 'package:ploofypaws/pages/auth/sign-up/sign_up.dart';
import 'package:ploofypaws/pages/pet_onboarding/pet_onboard.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:ploofypaws/services/networking/exceptions.dart';
import 'package:ploofypaws/services/repositories/auth/auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/location/map_location.dart';

import '../../../services/repositories/auth/firebase/fire_assets.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isSuffixIconVisible = false;
  bool _loading = false;
  bool _googleLoading = false;

  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late UserDatabaseService _databaseService;
  late UserProvider userProvider;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _databaseService = _getIt.get<UserDatabaseService>();
    userProvider = context.read<UserProvider>();
  }

  void _handleLogin(String? email) {
    setState(() {
      _loading = true;
    });
    try {
      showCupertinoModalBottomSheet(
          useRootNavigator: true,
          enableDrag: false,
          context: context,
          builder: (context) {
            return SignInOtp(email: email);
          });
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
      final user = await _authServices.signInWithGoogle();
      if (!(await _databaseService.isEmailAlreadyRegistered(user!.email!))) {
        _databaseService.createUserProfile(
            userProfile: UserModel(
                id: user.id,
                displayName: user.displayName,
                email: user.email,
                photoUrl: user.photoUrl));
      }

      final storage = await SharedPreferences.getInstance();
      storage.setString('auth', jsonEncode(user));

      if (!mounted) return;

      userProvider.setUser(user!);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialWithModalsPageRoute(
              builder: (context) => const PetOnboarding()),
          (route) => false);
    } on APIError catch (e) {
      print(e);
    }
    setState(() {
      _googleLoading = false;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      _handleLogin(data['email']);
    }
  }

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
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 24),
          FormBuilder(
            key: _formKey,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('Sign In', style: typography(context).title1),
                  const SizedBox(height: 24),
                  const InputLabel(label: 'Email'),
                  FormBuilderTextField(
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
                                  _formKey.currentState!.fields['email']!
                                      .didChange('');
                                  _emailController.clear();
                                },
                                child: const Icon(
                                  Iconsax.close_circle,
                                  color: Colors.black,
                                ),
                              )
                            : null),
                    autofillHints: const [
                      AutofillHints.email,
                      AutofillHints.telephoneNumber
                    ],
                    name: 'email',
                    validator: FormBuilderValidators.email(
                      errorText: 'Please enter a valid email address',
                    ),
                  ),
                  const SizedBox(height: 40),
                  const InputLabel(label: 'Password'),
                  FormBuilderTextField(
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password = value;
                    },
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        suffixIcon: isSuffixIconVisible
                            ? GestureDetector(
                                onTap: () {
                                  _formKey.currentState!.fields['password']!
                                      .didChange('');
                                  _passwordController.clear();
                                },
                                child: const Icon(
                                  Iconsax.close_circle,
                                  color: Colors.black,
                                ),
                              )
                            : null),
                    autofillHints: const [
                      AutofillHints.password,
                    ],
                    name: 'password',
                    validator: FormBuilderValidators.required(
                      errorText: 'Please enter your password',
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const ResetPasswordInstructions()));
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  Button(
                    loading: _loading,
                    onPressed: () async {
                      if (_formKey.currentState!.saveAndValidate()) {
                        final userAuth = await _authServices.login(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        if (userAuth != null) {
                          final user = await _databaseService
                              .getUserProfileByUID(userAuth.id!);
                          userProvider.setUser(user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Root(),
                              ));
                        }
                      }
                    },
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
                    label: 'Continue with Google',
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
                        "Don't have an account?",
                        style: typography(context).smallBody.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          'Sign up for free',
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
          FutureBuilder(
              future: getImageUrl('assets/images/auth/sign-in.png'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator(color: Colors.black);
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading'),
                  ); // Handle any errors
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('No data available'),
                  ); // Handle the case where there's no data
                } else {
                  return Image.network(
                    snapshot.data!,
                    scale: 2.0,
                  );
                }
              }),
        ],
      ),
    ));
  }
}
