import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/tracker/map/map_widget.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart'
    as cbi;

class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    final mq = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyMapWidget(),
        ));
      },
      child: Container(
        // padding: const EdgeInsets.all(16),
        height: MediaQuery.sizeOf(context).height * 0.28,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xff1A1A1A), Color(0xffB8E8E8E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              if (urlProvider.urlMap['assets/images/content/device_bg.png'] !=
                  null)
                Positioned(
                  bottom: 0,
                  child: CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap['assets/images/content/device_bg.png']!,
                    color: Colors.grey,
                    placeholder: null,
                    errorWidget: null,
                  ),
                ),
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: CachedNetworkImageProvider(
                              urlProvider
                                  .urlMap['assets/images/content/dog.png']!,
                            ),
                          ),
                          const SizedBox(width: 16),
                          _buildHeader("Arlo's Tracker"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Version: ",
                            style: TextStyle(
                                color: Colors.grey[50],
                                fontWeight: FontWeight.bold),
                          ),
                          Text("2g", style: TextStyle(color: Colors.grey[50])),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "IMEI: ",
                            style: TextStyle(
                                color: Colors.grey[50],
                                fontWeight: FontWeight.bold),
                          ),
                          Text("7998*****",
                              style: TextStyle(color: Colors.grey[50])),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: mq.height * 0.06,
                  left: mq.width * 0.18,
                  child: IconButton(
                      onPressed: () {},
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.transparent,
                        ),
                        child: const Icon(
                          Icons.navigation_outlined,
                          color: Colors.white,
                        ),
                      ))),
              Positioned(
                  bottom: mq.height * 0.06,
                  left: mq.width * 0.04,
                  child: IconButton(
                      onPressed: () {},
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.transparent,
                        ),
                        child: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ))),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap['assets/images/content/tracker_2g.png']!,
                    placeholder: null,
                    errorWidget: null,
                  )),
              Positioned(
                top: mq.height * 0.03,
                right: mq.width * 0.05,
                child: Container(
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff5B5B5B),
                  ),
                  child: const cbi.BatteryIndicator(
                    value: 0.6,
                    trackHeight: 10,
                    barColor: Colors.white,
                    trackColor: Colors.black,
                    trackBorderColor: Colors.white,
                  ),
                ),
              ),
              Positioned(
                  bottom: mq.height * 0.02,
                  left: mq.width * 0.06,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.transparent,
                    ),
                    child: const Text(
                      "Rohini Sec-4",
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: typography(context).title3.copyWith(color: Colors.white),
    );
  }
}
