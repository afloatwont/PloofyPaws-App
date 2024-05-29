import 'package:flutter/material.dart';

class ResetPasswordInstructions extends StatefulWidget {
  const ResetPasswordInstructions({super.key});

  @override
  State<ResetPasswordInstructions> createState() => _ResetPasswordInstructionsState();
}

class _ResetPasswordInstructionsState extends State<ResetPasswordInstructions> {
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
                          "An email with a link to reset your password was just sent to your email. Please check your inbox."),
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
