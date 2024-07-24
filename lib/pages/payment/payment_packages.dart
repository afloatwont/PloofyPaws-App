import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PaymentPackage extends StatefulWidget {
  const PaymentPackage({super.key});

  @override
  State<PaymentPackage> createState() => _PaymentPackageState();
}

class _PaymentPackageState extends State<PaymentPackage> {
  double price = 299.0; // Example static price value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Your Plan",
          style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [
          Text(
            "FAQ",
            style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            width: 3,
          ),
          Image.asset("assets/Vector.png", height: 17, width: 17),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 46,
                      width: 380,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(71)),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 170),
                          child: Text(
                            "Yearly",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 46,
                      width: 190,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(71)),
                          border: Border(
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                              bottom: BorderSide(color: Colors.black))),
                      child: Center(
                        child: Text(
                          "Monthly",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: 390,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: HexColor("#00000021"),
                      offset: const Offset(0, 4),
                      blurRadius: 39.4,
                      spreadRadius: 0)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Base",
                          style: GoogleFonts.poppins(
                              fontSize: 32, fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Text("Regular Location Updates every 2-60 min",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: HexColor("#181059")))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                                "Unlimited LIVE Tracking Updates every 2-3 sec",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: HexColor("#181059"))),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                                "Activity & sleep plus wellness features",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: HexColor("#181059"))),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.close,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                                "Family Sharing Let many people track at once",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.close,
                            size: 18,
                          ),
                          Expanded(
                            child: Text("Worldwide Coverage*",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.close,
                            size: 18,
                          ),
                          Expanded(
                            child: Text("365 Day Location History",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.close,
                            size: 18,
                          ),
                          Expanded(
                            child: Text("GPS data export",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const Text("₹"),
                          Text("$price",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              )),
                          Text("/month",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: HexColor("#2C2C2C"))),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                                color: HexColor("#D7FFE1"),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Save ₹1829",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: HexColor("#34A853")),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/Rectangle.png",
                              height: 90,
                            ),
                          ),
                          Positioned(
                            child: Container(
                              width: 361.77,
                              height: 53.91,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text("Choose",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ),
            Container(
              width: 390,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: HexColor("#00000021"),
                      offset: const Offset(0, 4),
                      blurRadius: 39.4,
                      spreadRadius: 0)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Premium",
                          style: GoogleFonts.poppins(
                              fontSize: 32, fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Text("Regular Location Updates every 2-60 min",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: HexColor("#181059")))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                                "Unlimited LIVE Tracking Updates every 2-3 sec",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: HexColor("#181059"))),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                                "Activity & sleep plus wellness features",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: HexColor("#181059"))),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                                "Family Sharing Let many people track at once",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text("Worldwide Coverage*",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text("365 Day Location History",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 18,
                          ),
                          Expanded(
                            child: Text("GPS data export",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: HexColor("#676767"))),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const Text("₹"),
                          Text("${price + 100}", // Example static premium price value
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              )),
                          Text("/month",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: HexColor("#2C2C2C"))),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                                color: HexColor("#D7FFE1"),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Save ₹1829",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: HexColor("#34A853")),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/Rectangle.png",
                              height: 90,
                            ),
                          ),
                          Positioned(
                            child: Container(
                              width: 361.77,
                              height: 53.91,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text("Choose",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentPackage(),
  ));
}
