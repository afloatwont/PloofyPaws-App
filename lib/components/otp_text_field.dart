import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.buildContext,
    required this.otpController,
    this.onChanged,
    this.onCompleted,
  });

  final BuildContext buildContext;
  final TextEditingController otpController;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: buildContext,
      enablePinAutofill: true,
      autoFocus: true,
      length: 6,
      obscureText: false,
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        inactiveColor: Colors.black,
        inactiveFillColor: Colors.white,
        activeColor: Colors.black,
        selectedColor: Colors.black,
        selectedFillColor: Colors.white,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
      ),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: otpController,
      errorTextMargin: EdgeInsets.zero,
      keyboardType: TextInputType.number,
      textStyle: const TextStyle(fontSize: 20, height: 1.6),
      onCompleted: onCompleted,
      onChanged: onChanged ?? (v) {},
      beforeTextPaste: (text) {
        // debugPrint("Allowing to paste $text");
        return true;
      },
    );
  }
}
