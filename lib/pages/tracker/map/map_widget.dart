import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MyMapWidget extends StatefulWidget {
  const MyMapWidget({super.key});

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  MapboxMap? map;

  @override
  void initState() {
    super.initState();
    String? accessToken = dotenv.env['MAPBOX_DOWNLOADS_TOKEN'];
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Mapbox access token is not set');
    }
    MapboxOptions.setAccessToken(accessToken);
  }

  void _onMapCreated(MapboxMap map) {
    setState(() {
      this.map = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        onMapCreated: _onMapCreated,
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(20.88, 78.67)),
          zoom: 10,
        ),
      ),
    );
  }
}
