import 'package:flutter/material.dart';
import 'package:restoe/config/theme/theme.dart';

class AddressFormBottomSheet extends StatefulWidget {
  const AddressFormBottomSheet({Key? key}) : super(key: key);

  @override
  AddressFormBottomSheetState createState() => AddressFormBottomSheetState();
}

class AddressFormBottomSheetState extends State<AddressFormBottomSheet> {
  String address = '';

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
          const Text(
            'Enter complete address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(labelText: 'Enter Address'),
            onChanged: (value) {
              setState(() {
                address = value;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print('Address submitted: $address');
            },
            child: const Text('Submit',style:TextStyle(
              fontSize: 17,
              color: Colors.white
            ),),
          ),
        ],
      ),
    );
  }
}
