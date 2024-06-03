import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restoe/components/adaptive_page_scaffold.dart';
import 'package:restoe/components/button.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  Future<void> _requestPermission(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var version = androidInfo.version.release;
      final int majorVersion = int.parse(version.split('.')[0]);
      if (majorVersion < 13) {
        PermissionStatus status = await Permission.storage.request();
        _openImagePicker(context, status);
      } else {
        PermissionStatus status = await Permission.photos.request();
        _openImagePicker(context, status);
      }
    } else {
      PermissionStatus status = await Permission.photos.request();
      _openImagePicker(context, status);
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission required'),
        content: const Text('Please enable photo access in the app settings.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _openImagePicker(BuildContext context, PermissionStatus status) async {
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {}
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Permission Denied"),
          duration: Duration(seconds: 3),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //         "Permission Permanently Denied. Please enable from settings."),
      // )
      // );
      _showSettingsDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
      previousPageTitle: 'create_pet_memorial',
      automaticallyImplyLeading: false,
      appBarTrailing: IconButton(
        icon: const Icon(Icons.clear_outlined),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Upload Photo',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[200]),
              child: Icon(
                Icons.image_outlined,
                size: 60,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'The application does not yet have access to your camera, please allow to get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 55,
              width: 330,
              child: Button(
                onPressed: () => _requestPermission(context),
                variant: 'filled',
                label: 'Allow Access to library',
                size: 16,
                buttonColor: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
