import 'package:flutter/material.dart';

import 'location.dart';

class LocationPopup extends StatefulWidget {
  const LocationPopup({super.key});

  @override
  LocationPopupState createState() => LocationPopupState();
}

class LocationPopupState extends State<LocationPopup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomModalSheet(context);
      },
      child: const Scaffold(
        body: Center(
          child: Text(
            'Tap to show bottom modal sheet',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _showBottomModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Just one last thing',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Please enter the address so that we can find the best available slots at your location.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressFormScreen()),
                  );
                },
                child: const Text('Enter Address'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
