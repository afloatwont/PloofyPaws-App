import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class AddressFormScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Center(child: LocationPicker()), // Replaced placeholder with LocationPicker widget
          ),
          ElevatedButton(
            onPressed: () => _showAddressFormBottomSheet(context, ref),
            child: const Text('Enter Address Details'),
          ),
        ],
      ),
    );
  }

  void _showAddressFormBottomSheet(BuildContext context, WidgetRef ref) {
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
              child: AddressFormContent(),
            );
          },
        );
      },
    );
  }
}

class AddressFormContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(addressProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context),
        const SizedBox(height: 8),
        _buildRadioButtons(context, ref, address),
        const SizedBox(height: 8),
        _buildAddressTypeChips(context, ref, address),
        const SizedBox(height: 16),
        _buildTextFields(context, ref, address),
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

  Widget _buildRadioButtons(BuildContext context, WidgetRef ref, Address address) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: address.isForMyself,
          onChanged: (value) {
            ref.read(addressProvider.notifier).update((state) => state.copyWith(isForMyself: value!));
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
            ref.read(addressProvider.notifier).update((state) => state.copyWith(isForMyself: value!));
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

  Widget _buildAddressTypeChips(BuildContext context, WidgetRef ref, Address address) {
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
                  ref.read(addressProvider.notifier).update((state) => state.copyWith(saveAs: label));
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

  Widget _buildTextFields(BuildContext context, WidgetRef ref, Address address) {
    return Column(
      children: [
        _buildTextField(
          context,
          labelText: 'Flat / House no / Floor / Building *',
          onChanged: (value) {
            ref.read(addressProvider.notifier).update((state) => state.copyWith(flatNo: value));
          },
        ),
        const SizedBox(height: 8),
        _buildTextField(
          context,
          labelText: 'Area / Sector / Locality',
          onChanged: (value) {
            ref.read(addressProvider.notifier).update((state) => state.copyWith(area: value));
          },
        ),
        const SizedBox(height: 8),
        _buildTextField(
          context,
          labelText: 'Nearby landmark (optional)',
          onChanged: (value) {
            ref.read(addressProvider.notifier).update((state) => state.copyWith(landmark: value));
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

final addressProvider = StateProvider<Address>((ref) {
  return Address();
});

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late MapController mapController;
  LatLng? currentLocation;

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
    });

    mapController.move(currentLocation!, 12.0);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: currentLocation?? const LatLng(51.5, -0.09),
        initialZoom: 5,
        maxZoom: 5,
        minZoom: 3,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: currentLocation != null
              ? [
            Marker(
              width: 80.0,
              height: 80.0,
              point: currentLocation!,
              child:
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40.0,
                  ),
            ),
          ]
              : [], // Empty list if currentLocation is null
        ),
      ],
    );
  }
}
