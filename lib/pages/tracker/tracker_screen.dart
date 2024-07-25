import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/pages/tracker/input_imei.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    return Scaffold(
      backgroundColor: const Color(0xff141414),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Iconsax.menu_14,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff2D2D2D),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: MediaQuery.sizeOf(context).height * 0.95,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color(0xff2D2D2D),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap['assets/images/content/tracker_main1.png']!,
                    // height: MediaQuery.sizeOf(context).height * 0.2,
                    placeholder: null,
                    errorWidget: null,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Ploofy Tracker',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'Where safety meets style',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(Iconsax.alarm,
                            color: Colors.white, size: 30),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(Iconsax.heart,
                            color: Colors.white, size: 30),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(Iconsax.location,
                            color: Colors.white, size: 30),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(Iconsax.mobile,
                            color: Colors.white, size: 30),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(Iconsax.battery_full,
                            color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  const SizedBox(height: 30),
                  SwipeButton(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    height: MediaQuery.sizeOf(context).height * 0.08,
                    thumb: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 162, 162, 162),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(
                                    3, 3), // Shadow position to the right
                                blurRadius:
                                    6, // Optional: adjust for softer shadow edges
                              ),
                            ],
                          ),
                        )),
                    activeThumbColor: const Color.fromARGB(255, 255, 255, 255),
                    activeTrackColor: const Color(0xff888888),
                    onSwipe: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const
                                // TrackerPairingMode(),
                                InputImeiScreen(),
                          ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Swipe to buy...",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_right_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff2D2D2D),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Ploofy's Tracker include",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: urlProvider
                            .urlMap['assets/images/content/Location.png']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Real-Time Location Tracking',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Keep tabs on your pet's whereabouts with accurate real-time GPS tracking.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: urlProvider
                            .urlMap['assets/images/content/Siren.png']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Geofencing Alerts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Set up safe zones and receive alerts if your pet goes beyond designated boundaries.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: urlProvider
                            .urlMap['assets/images/content/Heart_monitor.png']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Activity Monitoring',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Track your pet's activity levels and health metrics to ensure their well-being.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: urlProvider
                            .urlMap['assets/images/content/Smartphones.png']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Compatibility and Ease of Use',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Choose a tracker that is user-friendly and compatible with your devices.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: urlProvider.urlMap[
                            'assets/images/content/Charging_battery.png']!,
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Long Battery Life',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'A long-lasting battery to keep your pet protected around the clock.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            CachedNetworkImage(
              width: MediaQuery.sizeOf(context).width,
              imageUrl:
                  urlProvider.urlMap['assets/images/content/tracker_dog.png']!,
              height: MediaQuery.sizeOf(context).height * 0.4,
              placeholder: null,
              fit: BoxFit.cover,
              errorWidget: null,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 50),
            CachedNetworkImage(
              width: MediaQuery.sizeOf(context).width,
              imageUrl: urlProvider
                  .urlMap['assets/images/content/tracker_instruction_1.png']!,
              height: MediaQuery.sizeOf(context).height * 0.4,
              placeholder: null,
              fit: BoxFit.cover,
              errorWidget: null,
            ),
            // const SizedBox(height: 50),
            CachedNetworkImage(
              width: MediaQuery.sizeOf(context).width,
              imageUrl: urlProvider
                  .urlMap['assets/images/content/tracker_instruction_2.png']!,
              height: MediaQuery.sizeOf(context).height * 0.4,
              placeholder: null,
              // fit: BoxFit.cover,
              errorWidget: null,
            ),
            // const SizedBox(height: 50),
            CachedNetworkImage(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.6,
              imageUrl:
                  urlProvider.urlMap['assets/images/content/tracker_card.png']!,
              placeholder: null,
              fit: BoxFit.contain,
              errorWidget: null,
            ),
            const SizedBox(height: 50),
            const PricingScreen(),
          ],
        ),
      ),
    );
  }
}

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  _PricingScreenState createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  bool isMonthly = true;

  final List<Map<String, dynamic>> pricingOptions = [
    {
      'title': 'Base',
      'features': [
        'Regular Location Updates Updates every 2-60 min',
        'Unlimited LIVE Tracking Updates every 2-3 sec',
        'Activity & Sleep Plus wellness features',
        'Family Sharing: Let many people track at once',
        'Worldwide Coverage*',
        '365 Day Location History',
        'GPS data export'
      ],
      'price': 800,
      'buttonText': 'Choose',
      'buttonColor': Colors.black,
      'saveText': 'Save ₹129',
      'highlightedFeatures': [0, 1, 2],
    },
    {
      'title': 'Premium',
      'features': [
        'Regular Location Updates Updates every 2-60 min',
        'Unlimited LIVE Tracking Updates every 2-3 sec',
        'Activity & Sleep Plus wellness features',
        'Family Sharing: Let many people track at once',
        'Worldwide Coverage*',
        '365 Day Location History',
        'GPS data export'
      ],
      'price': 800,
      'buttonText': 'Choose',
      'buttonColor': Colors.black,
      'saveText': '',
      'highlightedFeatures': [0, 1, 2, 3, 4, 5, 6],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isMonthly = true;
                });
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.42,
                decoration: BoxDecoration(
                  color: isMonthly ? Colors.white : Colors.black,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Monthly',
                  style: TextStyle(
                    color: isMonthly ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isMonthly = false;
                });
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.42,
                decoration: BoxDecoration(
                  color: !isMonthly ? Colors.white : Colors.black,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Yearly',
                  style: TextStyle(
                    color: !isMonthly ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...pricingOptions.map((option) => PricingCard(option)).toList(),
      ],
    );
  }
}

class PricingCard extends StatelessWidget {
  final Map<String, dynamic> option;

  const PricingCard(this.option, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option['title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff181059),
                ),
              ),
              const SizedBox(height: 10),
              ...option['features'].asMap().entries.map((entry) {
                int idx = entry.key;
                String feature = entry.value;
                bool isHighlighted =
                    option['highlightedFeatures'].contains(idx);
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        isHighlighted ? Icons.check : Icons.close,
                        color: isHighlighted ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            color:
                                isHighlighted ? Colors.black : Colors.black54,
                            decoration: isHighlighted
                                ? null
                                : TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              Text(
                '₹${option['price']} /month',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (option['saveText'].isNotEmpty)
                Text(
                  option['saveText'],
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: option['buttonColor'],
                  foregroundColor: Colors.white,
                  fixedSize: const Size.fromWidth(double.maxFinite),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text(option['buttonText']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
