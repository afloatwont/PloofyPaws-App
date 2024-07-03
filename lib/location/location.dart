import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  AddressFormScreenState createState() => AddressFormScreenState();
}

class AddressFormScreenState extends State<AddressFormScreen> {
  LatLng? currentLocation;
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _getCurrentLocation();
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
      mapController.move(currentLocation!, 12.0);
    });
  }

  void _updateLocation(LatLng newLocation) {
    setState(() {
      currentLocation = newLocation;
      mapController.move(currentLocation!, 12.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LocationPicker(currentLocation: currentLocation, mapController: mapController),
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

class LocationPicker extends StatelessWidget {
  final LatLng? currentLocation;
  final MapController mapController;

  const LocationPicker({super.key, this.currentLocation, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: currentLocation ?? const LatLng(51.5, -0.09),
        initialZoom: 12.0,
        maxZoom: 200,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        if (currentLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: currentLocation!,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
      ],
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
  _AddressFormBottomSheetState createState() => _AddressFormBottomSheetState();
}

class _AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  Address address = Address();

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
    widget.updateLocation(LatLng(locationData.latitude!, locationData.longitude!));
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
              child: AddressFormContent(
                address: address,
                onUpdate: (newAddress) {
                  setState(() {
                    address = newAddress;
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          const Center(
            child: Text(
              'Address Form Bottom Sheet',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          if (widget.currentLocation != null) ...[
            Text(
              'Latitude: ${widget.currentLocation!.latitude}, Longitude: ${widget.currentLocation!.longitude}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showAddressFormBottomSheet(context),
            child: const Text(
              'Enter Address Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressFormContent extends StatelessWidget {
  final Address address;
  final ValueChanged<Address> onUpdate;

  const AddressFormContent({
    super.key,
    required this.address,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
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

  Widget _buildRadioButtons(BuildContext context, Address address) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: address.isForMyself,
          onChanged: (value) {
            onUpdate(address.copyWith(isForMyself: value!));
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
            onUpdate(address.copyWith(isForMyself: value!));
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

  Widget _buildAddressTypeChips(BuildContext context, Address address) {
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
                  onUpdate(address.copyWith(saveAs: label));
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

  Widget _buildTextFields(BuildContext context, Address address) {
    return Column(
      children: [
        _buildTextField(
          context,
          labelText: 'Flat / House no / Floor / Building *',
          onChanged: (value) {
            onUpdate(address.copyWith(flatNo: value));
          },
        ),
        const SizedBox(height: 8),
        _buildTextField(
          context,
          labelText: 'Area / Sector / Locality',
          onChanged: (value) {
            onUpdate(address.copyWith(area: value));
          },
        ),
        const SizedBox(height: 8),
        _buildTextField(
          context,
          labelText: 'Nearby landmark (optional)',
          onChanged: (value) {
            onUpdate(address.copyWith(landmark: value));
          },
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, {required String labelText, required Function(String) onChanged}) {
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

  Widget _buildSaveButton(BuildContext context, Address address) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: () {
          print('Address saved: ${address.flatNo}, ${address.area}, ${address.landmark}');
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

class Address {
  final String flatNo;
  final String area;
  final String landmark;
  final bool isForMyself;
  final String saveAs;

  Address({
    this.flatNo = '',
    this.area = '',
    this.landmark = '',
    this.isForMyself = true,
    this.saveAs = 'Home',
  });

  Address copyWith({
    String? flatNo,
    String? area,
    String? landmark,
    bool? isForMyself,
    String? saveAs,
  }) {
    return Address(
      flatNo: flatNo ?? this.flatNo,
      area: area ?? this.area,
      landmark: landmark ?? this.landmark,
      isForMyself: isForMyself ?? this.isForMyself,
      saveAs: saveAs ?? this.saveAs,
    );
  }
}
