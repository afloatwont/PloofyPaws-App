import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_battery_indicator/cupertino_battery_indicator.dart'
    as cbi;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/input_label.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/tracker/map/map_widget.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DeviceFound extends StatefulWidget {
  final BarcodeCapture? barcodeCapture;

  const DeviceFound({super.key, this.barcodeCapture});

  @override
  State<DeviceFound> createState() => _DeviceFoundState();
}

class _DeviceFoundState extends State<DeviceFound> {

  Future<void> fetchData(String imei) async {
    final response = await http.get(Uri.parse(
        'https://vahantrack.com/api/api.php?api=user&ver=1.0&key=E43FEC932566D9E32F1CD2DC3F5CAE01&cmd=OBJECT_GET_LOCATIONS,$imei'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['861261029438534'];
      final latitude = double.parse(data['lat']);
      final longitude = double.parse(data['lng']);
      final battery = double.parse(data['params']['bats']);
      final trackerDateTime = DateTime.parse(data['dt_tracker']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    final mq = MediaQuery.sizeOf(context);
    return AdaptivePageScaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InputLabel(label: 'Devices found', size: 24),
              ListView.separated(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
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
                              colors: [Color(0xff1A1A1A), Color(0xffb8e8e8e)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            if (urlProvider.urlMap[
                                    'assets/images/content/device_bg.png'] !=
                                null)
                              Positioned(
                                bottom: 0,
                                child: CachedNetworkImage(
                                  imageUrl: urlProvider.urlMap[
                                      'assets/images/content/device_bg.png']!,
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
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            urlProvider.urlMap[
                                                'assets/images/content/dog.png']!,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        _buildHeader("Arlo's Tracker"),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Version: ",
                                          style: TextStyle(
                                              color: Colors.grey[50],
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("2g",
                                            style: TextStyle(
                                                color: Colors.grey[50])),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "IMEI: ",
                                          style: TextStyle(
                                              color: Colors.grey[50],
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("7998*****",
                                            style: TextStyle(
                                                color: Colors.grey[50])),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: mq.height * 0.06,
                                left: mq.width * 0.1,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent,
                                      ),
                                      child: const Icon(
                                        Icons.navigation_outlined,
                                        color: Colors.white,
                                      ),
                                    ))),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: CachedNetworkImage(
                                  imageUrl: urlProvider.urlMap[
                                      'assets/images/content/tracker_2g.png']!,
                                  placeholder: null,
                                  errorWidget: null,
                                )),
                            Positioned(
                              top: mq.height * 0.03,
                              right: mq.width * 0.05,
                              child: cbi.BatteryIndicator(
                                value: 0.6,
                                barColor: Colors.white,
                                trackColor: Colors.grey[500],
                              ),
                            ),
                            Positioned(
                                bottom: mq.height * 0.02,
                                left: mq.width * 0.06,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
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
                    );
                  }),
              const SizedBox(height: 16),
              //saved devices list view
              const InputLabel(label: 'Saved Devices', size: 24),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Device $index'),
                    );
                  }),
            ],
          ),
        ),
      )
    ]));
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: typography(context).title3.copyWith(color: Colors.white),
    );
  }
}

class ProgressRing extends StatelessWidget {
  final double percent;
  final Color backgroundColor;
  final Color foregroundColor;

  const ProgressRing(
      {super.key,
      required this.percent,
      required this.backgroundColor,
      required this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(
        children: [
          CircularProgressIndicator(
            backgroundColor: backgroundColor,
            strokeWidth: 5.0,
            value: percent / 100,
          ),
          Center(
            child: Text(
              '${percent.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
