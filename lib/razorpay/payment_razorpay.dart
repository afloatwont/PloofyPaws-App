import 'package:flutter/material.dart';
import 'package:ploofypaws/video_call/screens/join_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayScreen extends StatefulWidget {
  const RazorPayScreen({super.key});

  @override
  RazorPayScreenState createState() => RazorPayScreenState();
}

class RazorPayScreenState extends State<RazorPayScreen>
    with SingleTickerProviderStateMixin {
  Razorpay? _razorpay;
  String _paymentStatus = "Idle";
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

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

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // Replace with your Razorpay key
      'amount': 30000, // Fixed amount in paise (300 INR)
      'name': 'PloofyPaws.',
      'description': 'Fine T-Shirt',
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Razorpay Payment'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Amount to be paid: 300 INR',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  openCheckout();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    fixedSize: Size(double.maxFinite,
                        MediaQuery.sizeOf(context).height * 0.06)),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _slideAnimation,
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
            ],
          ),
        ),
      ),
    );
  }
}
