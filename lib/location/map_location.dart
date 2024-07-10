import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mb;
import 'package:ploofypaws/services/alert/alert_service.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ploofypaws/config/theme/theme.dart';

class AddAddressSheet extends StatelessWidget {
  const AddAddressSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Wrap(
        children: [
          const Text(
            "Before you continue, kindly add your address!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: Size.fromWidth(double.maxFinite),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const AddressFormScreen(),
                );
              },
              child: const Text('Add Address',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  AddressFormScreenState createState() => AddressFormScreenState();
}

class AddressFormScreenState extends State<AddressFormScreen> {
  LatLng? currentLocation;
  mb.MapboxMap? mapboxMap;

  @override
  void initState() {
    final add = context.read<AddressModel>();
    super.initState();
    _getCurrentLocation().then(
      (value) {
        getPlace(currentLocation!).then(
          (value) {
            add.updateLocation(value);
          },
        );
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if location permissions are granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get current location
    var locationData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
      mapboxMap?.flyTo(
        mb.CameraOptions(
          center: mb.Point(
            coordinates:
                mb.Position(locationData.longitude!, locationData.latitude!),
          ),
          zoom: 12,
        ),
        mb.MapAnimationOptions(duration: 1),
      );
    });
  }

  Future<String> getPlace(LatLng location) async {
    String res = "Unknown place";
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${location.latitude}&lon=${location.longitude}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      res = data['display_name'] ?? "Unknown place";
    } else {
      print('Failed to get place: ${response.statusCode}');
    }

    return res;
  }

  void _onMapCreated(mb.MapboxMap map) {
    setState(() {
      mapboxMap = map;
    });
  }

  void _updateLocation(LatLng newLocation) {
    setState(() {
      currentLocation = newLocation;
      mapboxMap?.flyTo(
        mb.CameraOptions(
          center: mb.Point(
            coordinates:
                mb.Position(newLocation.longitude, newLocation.latitude),
          ),
          zoom: 12,
        ),
        mb.MapAnimationOptions(duration: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: LocationPicker(
                currentLocation: currentLocation, onMapCreated: _onMapCreated),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: AddressFormBottomSheet(
                currentLocation: currentLocation,
                updateLocation: _updateLocation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationPicker extends StatefulWidget {
  final LatLng? currentLocation;
  final Function(mb.MapboxMap) onMapCreated;

  const LocationPicker(
      {super.key, this.currentLocation, required this.onMapCreated});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? accessToken = dotenv.env['MAPBOX_DOWNLOADS_TOKEN'];
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('Mapbox access token is not set');
    }
    mb.MapboxOptions.setAccessToken(accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return mb.MapWidget(
      key: const ValueKey("mapWidget"),
      onMapCreated: widget.onMapCreated,
      cameraOptions: mb.CameraOptions(
        center: widget.currentLocation != null
            ? mb.Point(
                coordinates: mb.Position(
                  widget.currentLocation!.longitude,
                  widget.currentLocation!.latitude,

                ),
              )
            : mb.Point(
                coordinates:
                    mb.Position(20.88, 78.67), // Default to some location
              ),
        zoom: 1,
      ),
      mapOptions: mb.MapOptions(pixelRatio: 4),
    );
  }
}

class AddressFormBottomSheet extends StatefulWidget {
  final LatLng? currentLocation;
  final ValueChanged<LatLng> updateLocation;

  const AddressFormBottomSheet({
    super.key,
    required this.currentLocation,
    required this.updateLocation,
  });

  @override
  State<AddressFormBottomSheet> createState() => _AddressFormBottomSheetState();
}

class _AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      widget.updateLocation(
          LatLng(locationData.latitude!, locationData.longitude!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<AddressModel>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.currentLocation != null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                address.location ?? "Unknown",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ] else ...[
            const Text(
              'Fetching location...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () => _showAddressFormBottomSheet(context),
              child: const Text('Confirm Location',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

void _showAddressFormBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Enter Address Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Address Line 1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Address Line 2',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Postal Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // Handle address form submission
                  },
                  child: const Text('Submit',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class AddressFormContent extends StatefulWidget {
  const AddressFormContent({super.key});

  @override
  State<AddressFormContent> createState() => _AddressFormContentState();
}

class _AddressFormContentState extends State<AddressFormContent> {
  final _getIt = GetIt.instance;
  late AuthServices _authServices;
  late UserDatabaseService _userDatabaseService;
  late AlertService _alertService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _alertService = _getIt.get<AlertService>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<AddressModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        const SizedBox(height: 8),
        _buildRadioButtons(context, address),
        const SizedBox(height: 8),
        _buildAddressTypeChips(context, address),
        const SizedBox(height: 16),
        _buildTextFields(context, address),
        const SizedBox(height: 16),
        _buildSaveButton(context, address),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter complete address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Who are you ordering for?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButtons(BuildContext context, AddressModel address) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: address.isForMyself,
          onChanged: (value) {
            address.updateIsForMyself(value!);
          },
        ),
        const Text(
          'Myself',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        Radio<bool>(
          value: false,
          groupValue: address.isForMyself,
          onChanged: (value) {
            address.updateIsForMyself(value!);
          },
        ),
        const Text(
          'Someone else',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTypeChips(BuildContext context, AddressModel address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Save address as*',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 10,
          children: ['Home', 'Work', 'Hotel', 'Others'].map((label) {
            return ChoiceChip(
              label: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              selected: address.saveAs == label,
              onSelected: (selected) {
                if (selected) {
                  address.updateSaveAs(label);
                }
              },
              selectedColor: Colors.grey[200],
              disabledColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey, width: 1.0),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextFields(BuildContext context, AddressModel address) {
    return Column(
      children: [
        _buildTextField(
          context,
          labelText: 'Flat / House no / Floor / Building *',
          onChanged: (value) {
            address.updateFlatNo(value);
          },
        ),
        const SizedBox(height: 8),
        _buildTextField(
          context,
          labelText: 'Area / Sector / Locality',
          onChanged: (value) {
            address.updateArea(value);
          },
        ),
        const SizedBox(height: 8),
        _buildTextField(
          context,
          labelText: 'Nearby landmark (optional)',
          onChanged: (value) {
            address.updateLandmark(value);
          },
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context,
      {required String labelText, required Function(String) onChanged}) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.0),
          borderSide: BorderSide(color: Colors.grey[500]!),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildSaveButton(BuildContext context, AddressModel address) {
    final userProvier = Provider.of<UserProvider>(context);
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: () async {
          try {
            userProvier.updateAddress(address);
            await _userDatabaseService.updateAddress(
                _authServices.user!.uid, address);
            final user = await _userDatabaseService
                .getUserProfileByUID(userProvier.user!.id!);
            userProvier.setUser(user!);
            _alertService.showToast(
              text: "Address saved successfully",
              icon: Icons.check,
              color: Colors.green,
            );

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // Navigator.of(context).popUntil((route) => route
            // .isCurrent); // Close all bottom sheets and return to the initial page
          } catch (e) {
            print("Error saving address: $e");
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Text(
            'Save address',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
