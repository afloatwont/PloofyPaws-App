import 'package:flutter/material.dart';
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
  final TextEditingController _amountController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    setState(() {
      _amountController.text = "300.00";
    });
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _paymentStatus = "Payment Successful: ${response.paymentId}";
    });
    _animationController.forward();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _paymentStatus = "Payment Error: ${response.code} - ${response.message}";
    });
    _animationController.forward();
  }

  void openCheckout(String amount) async {
    // Since UPI is removed, prefill is no longer needed
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // Replace with your Razorpay key
      'amount': int.parse(amount) * 100, // Convert to paise
      'name': 'Acme Corp.',
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
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                  labelStyle: const TextStyle(color: Colors.black),
                  contentPadding: const EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    openCheckout(_amountController.text);
                  } else {
                    setState(() {
                      _paymentStatus = "Please enter the amount.";
                    });
                    _animationController.forward();
                  }
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
