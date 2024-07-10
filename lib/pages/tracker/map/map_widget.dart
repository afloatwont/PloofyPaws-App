import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mb;

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mapbox Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMapWidget(),
    );
  }
}

class MyMapWidget extends StatefulWidget {
  const MyMapWidget({super.key});

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  mb.MapboxMap? map;

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
    });
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
            child: const InfoCard(),
          ),
        ],
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
  const InfoCard({super.key});

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: BatteryIndicator(percentage: 75),
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
