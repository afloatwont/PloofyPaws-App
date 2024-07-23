import 'package:flutter/material.dart';
import 'package:ploofypaws/components/divider_with_text.dart';
import 'package:ploofypaws/components/faq_section.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/appointment/confirmation/bottom_button.dart';
import 'package:ploofypaws/pages/appointment/confirmation/coupon.dart';
import 'package:ploofypaws/pages/appointment/confirmation/order_details.dart';
import 'package:ploofypaws/pages/appointment/confirmation/order_preview.dart';
import 'package:ploofypaws/pages/vet_video_consultation/expert_consultation_section.dart';

class AppointmentConfirmation extends StatefulWidget {
  const AppointmentConfirmation({super.key});

  @override
  State<AppointmentConfirmation> createState() =>
      _AppointmentConfirmationState();
}

class _AppointmentConfirmationState extends State<AppointmentConfirmation> {
  final List<Map<String, String>> faqs = [
    {
      "question": "What is included in the pet walking package?",
      "answer":
          "The pet walking package includes daily walks, feeding, and playtime."
    },
    {
      "question": "How long are the walks?",
      "answer":
          "Each walk lasts for about 30 minutes to an hour, depending on your pet's needs."
    },
    {
      "question": "Are the walkers trained and certified?",
      "answer":
          "Yes, all our walkers are trained and certified to handle pets of all sizes and breeds."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
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
                  const OrderPreview(),
                  _buildHeader("Order Details"),
                  const OrderDetails(),
                  const AddCoupon(),
                  _buildHeader("Order Details"),
                  _buildPaymentInfoCard(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: _buildHeader(
                        "Get expert consultations on all concerns"),
                  ),
                  const ExpertConsultationsSection(showHeading: false),
                  FAQSection(faqs: faqs, showTitle: true),
                  buildDividerWithText(context, "Ploofypaws",
                      color: Colors.grey),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          const BottomButton(),
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

  Widget _buildPaymentInfoCard() {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        // height: mq.height * 0.45,
        width: mq.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: const Color(0xffeF3F3F3), width: 1),
        ),
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: _buildHeader("Billing Details"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildPrice(699, 50, 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice(int total, int discount, int service) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Item Total"),
                Text("₹$total"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Item Discount"),
                Text(
                  "-₹$discount",
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Service Fee"),
                Text("₹$service"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader("Grand Total"),
                _buildHeader("₹${total - discount + service}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
