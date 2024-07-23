import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryState();
}

final List<Map<String, int>> data = [
  {"Manicure": 499},
  {"Pedicure": 399},
  {"Grooming": 599},
  {"Food Pills": 899},
];

class _SummaryState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Summary"),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios), onPressed: () {}),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAppointmentCard(context),
            _buildSuggestionRow(),
            _buildPaymentInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionRow() {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 20),
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildSuggestion(
              data[index].keys.first, data[index].values.first);
        },
      ),
    );
  }

  Widget _buildSuggestion(String name, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.28,
        width: MediaQuery.sizeOf(context).width * 0.39,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffF3F3F3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: typography(context).strong,
            ),
            Text(
              "₹$price",
              style: typography(context).subtitle2,
            ),
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: Size(
                    double.maxFinite, MediaQuery.sizeOf(context).height * 0.03),
              ),
              child: const Text("+ Add"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: mq.height * 0.27,
        width: mq.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffF3F3F3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grooming for pet",
                  style: typography(context)
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            _buildTitle(),
            Expanded(
              child: _buildContent([
                "45 mins",
                "For all skin types",
                "6-step process, includes 10 min massage"
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    final urlProvider = context.watch<UrlProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: urlProvider.urlMap['assets/images/content/pug.png']!,
            placeholder: null,
            errorWidget: null,
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Advanced Grooming",
                style: typography(context).subtitle1,
              ),
              Text(
                "₹1399",
                style: typography(context)
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<String> content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: content.length,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 4,
              ),
              const SizedBox(width: 8),
              Flexible(child: Text(content[index])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width * 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text("Schedule for Later")),
        ElevatedButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppointmentDetails()));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width * 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            child: const Text("Request Now")),
      ],
    );
  }

  Widget _buildPaymentInfoCard() {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: mq.height * 0.36,
        width: mq.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffeF3F3F3), width: 1),
        ),
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
            // const Spacer(), // This will push the _buildPayment widget to the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: _buildOffer("Paytm UPI"),
                ),
              ],
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

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: typography(context).title3,
    );
  }

  Widget _buildOffer(String method) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: const Color.fromARGB(53, 82, 180, 107),
            borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hurray! You saved ₹50 on final bill",
              style: typography(context)
                  .subtitle2
                  .copyWith(color: const Color(0xff52B46B)),
            ),
          ],
        ),
      ),
    );
  }
}
