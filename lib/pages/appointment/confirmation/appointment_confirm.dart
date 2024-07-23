import 'package:flutter/material.dart';
import 'package:ploofypaws/components/section_header.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/appointment/confirmation/bottom_button.dart';
import 'package:ploofypaws/pages/appointment/confirmation/order_preview.dart';

class AppointmentConfirmation extends StatefulWidget {
  const AppointmentConfirmation({super.key});

  @override
  State<AppointmentConfirmation> createState() =>
      _AppointmentConfirmationState();
}

class _AppointmentConfirmationState extends State<AppointmentConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Confirmation"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderPreview(),
                  _buildHeader("Order Details"),
                ],
              ),
            ),
          ),
          // BottomButton()
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: typography(context).title3,
    );
  }
}
