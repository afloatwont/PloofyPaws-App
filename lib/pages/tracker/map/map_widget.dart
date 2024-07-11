import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mb;
import 'package:http/http.dart' as http;

class MyMapWidget extends StatefulWidget {
  const MyMapWidget({super.key});

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  mb.MapboxMap? map;
  double? batteryPercentage;
  mb.PointAnnotationManager? pointAnnotationManager;

  @override
  void initState() {
    super.initState();
    String? accessToken = dotenv.env['MAPBOX_DOWNLOADS_TOKEN'];
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Mapbox access token is not set');
    }
    mb.MapboxOptions.setAccessToken(accessToken);
  }

  void _onMapCreated(mb.MapboxMap map) {
    setState(() {
      this.map = map;
      map.style = mb.StyleManager();
      map.loadStyleURI("mapbox://styles/mapbox/light-v10");
      map.annotations.createPointAnnotationManager().then((manager) {
        pointAnnotationManager = manager;
      });
    });
  }

  Future<void> _updateLocation() async {
    final response = await http.get(Uri.parse(
        'https://vahantrack.com/api/api.php?api=user&ver=1.0&key=E43FEC932566D9E32F1CD2DC3F5CAE01&cmd=OBJECT_GET_LOCATIONS,861261029438534'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['861261029438534'];
      final latitude = double.parse(data['lat']);
      final longitude = double.parse(data['lng']);
      final battery = double.parse(data['params']['bats']);

      setState(() {
        batteryPercentage = battery;
      });

      if (map != null) {
        map!.flyTo(
          mb.CameraOptions(
            center: mb.Point(coordinates: mb.Position(longitude, latitude)),
            zoom: 15,
          ),
          mb.MapAnimationOptions(duration: 1000),
        );

        final ByteData bytes =
            await rootBundle.load('assets/images/content/dog.png');
        final Uint8List list = bytes.buffer.asUint8List();
        pointAnnotationManager?.create(mb.PointAnnotationOptions(
          geometry: mb.Point(coordinates: mb.Position(longitude, latitude)),
          image: list,
        ));
      }
    } else {
      throw Exception('Failed to load location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapView(onMapCreated: _onMapCreated),
          Positioned(
            top: 50,
            left: MediaQuery.sizeOf(context).width * 0.2,
            right: MediaQuery.sizeOf(context).width * 0.2,
            child: InfoCard(batteryPercentage: batteryPercentage),
          ),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.27,
        minChildSize: 0.27,
        maxChildSize: 0.7,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 60,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        height: MediaQuery.sizeOf(context).height * 0.14,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.my_location_outlined),
                                SizedBox(width: 10),
                                Text(
                                  "Street Name",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\t\t121/136, Pocket 8",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\t\tUpdated 1 min ago",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: _updateLocation,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              fixedSize:
                                  const Size.fromWidth(double.maxFinite)),
                          child: const Text(
                            "Update Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // Add more widgets here as needed
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MapView extends StatelessWidget {
  final Function(mb.MapboxMap) onMapCreated;

  const MapView({super.key, required this.onMapCreated});

  @override
  Widget build(BuildContext context) {
    return mb.MapWidget(
      key: const ValueKey("mapWidget"),
      onMapCreated: onMapCreated,
      cameraOptions: mb.CameraOptions(
        center: mb.Point(coordinates: mb.Position(20.88, 78.67)),
        zoom: 10,
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final double? batteryPercentage;

  const InfoCard({super.key, this.batteryPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Image.asset("assets/images/content/dog.png"),
              ),
              const SizedBox(width: 10),
              const UserInfo(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BatteryIndicator(percentage: batteryPercentage ?? 0),
          ),
        ],
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Arlo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          "Online",
          style: TextStyle(
            color: Colors.green,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class BatteryIndicator extends StatelessWidget {
  final double percentage;

  const BatteryIndicator({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(50, 50),
      painter: BatteryPainter(percentage: percentage),
    );
  }
}

class BatteryPainter extends CustomPainter {
  final double percentage;

  BatteryPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    double angle = 2 * 3.141592653589793238 * (percentage / 100);

    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    paint.color = Colors.green;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height),
        -3.141592653589793238 / 2, angle, false, paint);

    // Draw the percentage text
    TextSpan span = TextSpan(
      style: const TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.w300),
      text: '${percentage.toInt()}%',
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    double textX = size.width / 2 - tp.width / 2;
    double textY = size.height / 2 - tp.height / 2;
    tp.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
