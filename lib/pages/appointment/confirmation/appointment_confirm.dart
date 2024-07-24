import 'package:flutter/material.dart';
import 'package:ploofypaws/components/divider_with_text.dart';
import 'package:ploofypaws/components/faq_section.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/appointment/confirmation/coupon.dart';
import 'package:ploofypaws/pages/appointment/confirmation/order_details.dart';
import 'package:ploofypaws/pages/appointment/confirmation/order_preview.dart';
import 'package:ploofypaws/pages/vet_video_consultation/expert_consultation_section.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:ploofypaws/video_call/screens/join_screen.dart';

class AppointmentConfirmation extends StatefulWidget {
  const AppointmentConfirmation({super.key});

  @override
  State<AppointmentConfirmation> createState() => _AppointmentConfirmationState();
}

class _AppointmentConfirmationState extends State<AppointmentConfirmation> with SingleTickerProviderStateMixin {
  Razorpay? _razorpay;
  String _paymentStatus = "Idle";
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final List<Map<String, String>> faqs = [
    {
      "question": "What is included in the pet walking package?",
      "answer": "The pet walking package includes daily walks, feeding, and playtime."
    },
    {
      "question": "How long are the walks?",
      "answer": "Each walk lasts for about 30 minutes to an hour, depending on your pet's needs."
    },
    {
      "question": "Are the walkers trained and certified?",
      "answer": "Yes, all our walkers are trained and certified to handle pets of all sizes and breeds."
    },
  ];

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _razorpay?.clear();
    _animationController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    setState(() {
      _paymentStatus = "Payment Successful: ${response.paymentId}";
    });
    await _animationController.forward();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinScreen(),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _paymentStatus = "Payment Error: ${response.code} - ${response.message}";
    });
    _animationController.forward();
  }

  void openCheckout(int amount) async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // Replace with your Razorpay key
      'amount': amount * 100, // Amount in paise
      'name': 'PloofyPaws.',
      'description': 'Appointment Payment',
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final packageProvider = context.watch<PackageProvider>();
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
                  _buildHeader("Billing Details"),
                  _buildPaymentInfoCard(),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _paymentStatus,
                        style: TextStyle(
                          color: _paymentStatus.startsWith("Payment Successful")
                              ? Colors.green
                              : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: _buildHeader("Get expert consultations on all concerns"),
                  ),
                  const ExpertConsultationsSection(showHeading: false),
                  FAQSection(faqs: faqs, showTitle: true),
                  buildDividerWithText(context, "Ploofypaws", color: Colors.grey),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          BottomButton(onPressed: () => openCheckout(679)),
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
    final int total = 699;
    final int discount = 50;
    final int service = 30;
    final int grandTotal = total - discount + service;
    int price = context.read<PackageProvider>().package?.price ?? 699;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
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
              child: _buildPrice(price, 50, 30),
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

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BottomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 10,
      left: 0,
      right: 0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const ContinuousRectangleBorder(),
            padding: EdgeInsets.symmetric(vertical: 16.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Make Appointment   "),
                Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Colors.white,
                )
              ],
            ),
            Text(
              "You saved Rs.69 on Arlo's healthcare",
              style: typography(context).smallBody.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
