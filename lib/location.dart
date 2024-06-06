import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restoe/config/theme/theme.dart';

class AddressFormScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(addressProvider);

    return Scaffold(
      body: Column(
        children: [
          Container(height: 200, child: const Center(child: Text('data'))
              // GoogleMap(
              //   initialCameraPosition: CameraPosition(
              //     target: LatLng(28.7041, 77.1025), // Coordinates for Delhi, India
              //     zoom: 12,
              //   ),
              //   onMapCreated: (GoogleMapController controller) {},
              // ),
              ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter complete address',
                    style: typography(context)
                        .title1
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Text('Who are you ordering for?',
                      style: typography(context).smallBody.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey[600])),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Row(
                    children: [
                      Radio<bool>(
                        focusColor: Colors.red,
                        fillColor: const MaterialStatePropertyAll(Colors.red),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: Colors.red,
                        value: true,
                        groupValue: address.isForMyself,
                        onChanged: (value) {
                          ref.read(addressProvider.notifier).state =
                              address.copyWith(isForMyself: value!);
                        },
                      ),
                      Text(
                        'Myself',
                        style: typography(context).smallBody.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Radio<bool>(
                        focusColor: Colors.red,
                        fillColor: const MaterialStatePropertyAll(Colors.red),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: Colors.red,
                        value: false,
                        groupValue: address.isForMyself,
                        onChanged: (value) {
                          ref.read(addressProvider.notifier).state =
                              address.copyWith(isForMyself: value!);
                        },
                      ),
                      Text(
                        'Someone else',
                        style: typography(context).smallBody.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                  Text('Save address as*',
                      style: typography(context).smallBody.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: Colors.grey[600])),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: ['Home', 'Work', 'Hotel', 'Others']
                        .map((label) => ChoiceChip(
                              showCheckmark: false,
                              shadowColor: Colors.grey,
                              selectedColor: Colors.grey[200],
                              disabledColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              label: Text(label,
                                  style: typography(context).smallBody.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  )),
                              selected: address.saveAs == label,
                              onSelected: (selected) {
                                if (selected) {
                                  ref.read(addressProvider.notifier).state =
                                      address.copyWith(saveAs: label);
                                }
                              },
                            ))
                        .toList(),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 9)),
                  TextField(
                    decoration: InputDecoration(
                      // labelText: 'Flat / House no / Floor / Building *',
                      label: Text(
                        'Flat / House no / Floor / Building *',
                        style: typography(context)
                            .smallBody
                            .copyWith(color: Colors.grey[600], fontSize: 12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(color: Colors.grey[500]!),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(addressProvider.notifier).state =
                          address.copyWith(flatNo: value);
                    },
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Area / Sector / Locality',
                      labelStyle: typography(context)
                          .smallBody
                          .copyWith(color: Colors.grey[600], fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(color: Colors.grey[500]!),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(addressProvider.notifier).state =
                          address.copyWith(flatNo: value);
                    },
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nearby landmark (optional)',
                      labelStyle: typography(context)
                          .smallBody
                          .copyWith(color: Colors.grey[600], fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        borderSide: BorderSide(color: Colors.grey[500]!),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(addressProvider.notifier).state =
                          address.copyWith(flatNo: value);
                    },
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                  Center(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: () {
                        // Save the address or perform any action
                        print(
                            'Address saved: ${address.flatNo}, ${address.area}, ${address.landmark}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 65),
                        child: Text(
                          'Save address',
                          style: typography(context).subtitle1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension AddressCopyWith on Address {
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

class Address {
  String flatNo;
  String area;
  String landmark;
  bool isForMyself;
  String saveAs;

  Address({
    this.flatNo = '',
    this.area = '',
    this.landmark = '',
    this.isForMyself = true,
    this.saveAs = 'Home',
  });
}

final addressProvider = StateProvider<Address>((ref) {
  return Address();
});
