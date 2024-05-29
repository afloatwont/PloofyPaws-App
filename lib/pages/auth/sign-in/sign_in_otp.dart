import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restoe/components/adaptive_app_bar.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/components/countdown_timer.dart';
import 'package:restoe/components/input_label.dart';
import 'package:restoe/components/otp_text_field.dart';
import 'package:restoe/pages/auth/sign-in/sign_in_password.dart';

class SignInOtp extends StatefulWidget {
  final String? email;

  const SignInOtp({super.key, this.email});

  @override
  State<SignInOtp> createState() => _SignInOtpState();
}

class _SignInOtpState extends State<SignInOtp> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        appBar: AdaptiveAppBar(
          title: const Text('Enter OTP'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Iconsax.close_circle4)),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                          "An email with a 6-digit verification code was just sent to your ${widget.email}. Please check your inbox."),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const InputLabel(label: 'Enter the code'),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                // if (canResend) const
                                //const Text('Resend OTP'),
                                // if (!canResend)
                                CountDownTimer(
                                  secondsRemaining: 60,
                                  whenTimeExpires: () {
                                    setState(() {
                                      // _otpResponse?.resendAt = DateTime.now().toUtc().toIso8601String();
                                    });
                                  },
                                  countDownFormatter: (int seconds) {
                                    int minutes = seconds ~/ 60;
                                    int secondsRemaining = seconds % 60;

                                    return 'Resend OTP in $minutes:${secondsRemaining.toString().padLeft(2, '0')}';
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      OtpTextField(
                        buildContext: context,
                        otpController: _otpController,
                        onChanged: (value) {
                          setState(() {
                            // _errorOtp = "";
                          });
                        },
                        onCompleted: (value) {
                          // _validateOTP();
                        },
                      ),
                      // if (_errorOtp.isNotEmpty)
                      //   Text(
                      //     _errorOtp,
                      //     style: const TextStyle(color: Colors.red),
                      //   ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ]),
            ),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Button(
                      onPressed: () {},
                      variant: "filled",
                      label: 'Sign In',
                    ),
                    const SizedBox(height: 10),
                    Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showCupertinoModalBottomSheet(context: context, builder: (context) => const SignInPassword());
                      },
                      label: 'Sign in with password instead',
                      variant: 'text',
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
