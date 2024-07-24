import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ploofypaws/pages/tracker/pairing.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class InputImeiScreen extends StatefulWidget {
  const InputImeiScreen({super.key});

  @override
  State<InputImeiScreen> createState() => _InputImeiScreenState();
}

class _InputImeiScreenState extends State<InputImeiScreen> {
  final formKey = GlobalKey<FormState>();
  final imeiController = TextEditingController();
  String? imei;
  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter the code"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (urlProvider.urlMap['assets/images/content/imei.png'] != null)
              Padding(
                padding: const EdgeInsets.all(30),
                child: CachedNetworkImage(
                  imageUrl:
                      urlProvider.urlMap['assets/images/content/imei.png']!,
                  placeholder: null,
                  errorWidget: null,
                ),
              ),
            Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
                controller: imeiController,
                validator: (value) {
                  if (value == null || value.length != 15) {
                    return 'Please enter correct IMEI number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: "Enter IMEI number",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                setState(() {
                  imei = imeiController.text;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackerPairingMode(),
                    ));
              }
            },
            child: const Text("Activate")),
      ),
    );
  }
}
